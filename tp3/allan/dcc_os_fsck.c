#include "dcc_os_fsck.h"

void print_list(int *i_list, int tam, int flag){
    if(flag){
        for(int i=0; i< tam; i++){
            printf("Inode: %d\n", i+1);
        }
    }
    else{
        for(int i=0; i< tam; i++){
            if(i_list[i] == 1){
                printf("Inode: %d\n", i+1);
            }
        }
    }
    printf("\n");
}

int count_list(int *i_list, int tam){
    int count = 0;
    for(int i=0; i< tam; i++){
        count += i_list[i];
    }
    return count;
}

//recupera do ataque ao super bloco
int recoverFromSuperBlockAttack(FILE *f, long blocks, long blocksize, ext2_super_block *sb)
{
    fseek(f, blocks*blocksize, SEEK_SET);
    fread(sb, sizeof(ext2_super_block), 1, f);
    if(EXT2_MAGIC_NUMBER == sb->s_magic)
    {
        fseek(f, blocks*blocksize, SEEK_SET);
        fwrite(sb, sizeof(ext2_super_block), 1, f);
        sb->s_block_group_nr = 0;

        printf("Ocorreu um problema com o primeiro super bloco, deseja recuperar do problema(Sim[Y] e Não[N])?\n");
        char aux;
        scanf("%c", &aux);
        if(aux == 'Y')
        {
            scanf("%c", &aux);
            fseek(f, BASE_OFFSET, SEEK_SET);
            fwrite(sb, sizeof(ext2_super_block), 1, f);
            return 1;
        }else
        {
            scanf("%c", &aux);
            return -1;
        }
    }

    return 0;
}

//procura ataque ao superbloco
void checkSuperBlockAttack(FILE *f)
{
    ext2_super_block *sb = malloc(sizeof(ext2_super_block));
    if(sb == NULL)
    {
        printf("Erro ao alocar memória.\n");
        return;
    }

    fseek(f, BASE_OFFSET, SEEK_SET);
    fread(sb, sizeof(ext2_super_block), 1, f);
    if(sb->s_magic == 0)
    {
        if(recoverFromSuperBlockAttack(f, 8193, BASE_OFFSET, sb) == 0)
        {
            if(recoverFromSuperBlockAttack(f, 16384, 2*BASE_OFFSET, sb) == 0)
            {
                recoverFromSuperBlockAttack(f, 32768, 4*BASE_OFFSET, sb);
            }
        }
    }

    free(sb);
}

//imprime um arquivo qualquer
void showFile(FILE *f, ext2_super_block *sb, long seek)
{
    char values[BLOCKSIZE(sb->s_log_block_size)];
    fseek(f, seek, SEEK_SET);
    fread(values, sizeof(char), BLOCKSIZE(sb->s_log_block_size), f);
    for(int k = 0; k < BLOCKSIZE(sb->s_log_block_size); k++)
    {
        printf("%c", values[k]);
    }
    printf("\n");
}

//anda pelos blocos indiretos procurando os blocos finais
void walkOnLevelOfIndir(FILE *f, ext2_super_block *sb, int indir)
{
    int qtbl = BLOCKSIZE(sb->s_log_block_size)/4;
    __le32 blocks[qtbl];
    fread(blocks, sizeof(int), qtbl, f);

    for(int i = 0; i < qtbl; i++)
    {
        if(blocks[i] != 0)
        {
            if(indir == 0)
            {
                showFile(f, sb, blocks[i] * BLOCKSIZE(sb->s_log_block_size));
            }else
            {
                fseek(f, blocks[i] * BLOCKSIZE(sb->s_log_block_size), SEEK_SET);
                walkOnLevelOfIndir(f, sb, indir-1);
            }
        }
    }
}

//anda pelo inode procurando os blocos indiretos
void walkOnInode(FILE *f, ext2_super_block *sb, ext2_inode *inode)
{
    for(int i = 12; i < 15; i++)
    {
        if(inode->i_block[i] != 0)
        {
            fseek(f, BLOCKSIZE(sb->s_log_block_size) * inode->i_block[i], SEEK_SET);
            walkOnLevelOfIndir(f, sb, i - 12);
        }
    }
}

//le um diretório
void readDir(FILE *f, ext2_dir_entry *dir, int *seek)
{
    fread(&(dir->inode), sizeof(dir->inode), 1, f);
    fread(&(dir->rec_len), sizeof(dir->rec_len), 1, f);
    fread(&(dir->name_len), sizeof(dir->name_len), 1, f);
    fread(&(dir->file_type), sizeof(dir->file_type), 1, f);
    fread(dir->name, sizeof(char), dir->name_len, f);
    int i = dir->name_len;
    for(; i < MAX_FILENAME; i++) dir->name[i] = '\0';
    *seek += dir->rec_len;
}

//escreve em um diretório
void writeDir(FILE *f, ext2_dir_entry *dir)
{
    fwrite(&(dir->inode), sizeof(dir->inode), 1, f);
    fwrite(&(dir->rec_len), sizeof(dir->rec_len), 1, f);
    fwrite(&(dir->name_len), sizeof(dir->name_len), 1, f);
    fwrite(&(dir->file_type), sizeof(dir->file_type), 1, f);
    int padding = dir->rec_len - sizeof(dir->inode) - sizeof(dir->rec_len) - sizeof(dir->name_len) - sizeof(dir->file_type);
	if(padding > MAX_FILENAME)
	{
		fwrite(dir->name, sizeof(char), MAX_FILENAME, f);
		int i = 0;
		char aux = '\0';
		for(; i < padding - MAX_FILENAME; i++)
		{
			fwrite(&aux, sizeof(char), 1, f);
		}
	}
	else
	{
		fwrite(dir->name, sizeof(char), padding, f);
	}
}

void freeSlot(FILE *f, ext2_super_block *sb, ext2_inode *inode,int *bloco, int *seek, int file_size, int *real_rec_len){
    for(int i=0; i < 12 ;i++){
        fseek(f, inode->i_block[i]*BLOCKSIZE(sb->s_log_block_size), SEEK_SET);
        *seek = 0;
        ext2_dir_entry *dir = malloc(sizeof(ext2_dir_entry));
        if (dir == NULL){
            printf("Erro ao alocar memória.");
            return;
        }
        while(*seek < (BLOCKSIZE(sb->s_log_block_size))){
            fread(&(dir->inode), sizeof(dir->inode), 1, f);
            fread(&(dir->rec_len), sizeof(dir->rec_len), 1, f);
            fread(&(dir->name_len), sizeof(dir->name_len), 1, f);
            fread(&(dir->file_type), sizeof(dir->file_type), 1, f);
            fread(dir->name, sizeof(char), dir->name_len, f);
            dir->name[dir->name_len] = '\0';
            if(BLOCKSIZE(sb->s_log_block_size) == *seek + dir->rec_len){
                int liq_rec_len = sizeof(dir->inode) + sizeof(dir->rec_len) + sizeof(dir->name_len) + sizeof(dir->file_type) + dir->name_len;
                *real_rec_len = liq_rec_len + (liq_rec_len%4 != 0 ? (4 - liq_rec_len%4) : 0);
                if(file_size <= dir->rec_len - *real_rec_len){
                    *bloco = i;
                    fseek(f, inode->i_block[i] * BLOCKSIZE(sb->s_log_block_size) + *seek, SEEK_SET);
					free(dir);
                    return;
                }
            }
            *seek += dir->rec_len;
            fseek(f, inode->i_block[i] * BLOCKSIZE(sb->s_log_block_size) + *seek, SEEK_SET);
        }
        free(dir);
    }
}

void replaceOrphans(FILE *f, int found_inode, int *i_list, ext2_super_block *sb, int group_count){
    int group = found_inode/sb->s_inodes_per_group;
    int rel_inode = found_inode%sb->s_inodes_per_group;
    fseek(f, group * sizeof(ext2_group_desc) + BLOCKSIZE(sb->s_log_block_size) + BASE_OFFSET, SEEK_SET);
    ext2_group_desc *gd = malloc(sizeof(ext2_group_desc));
    if(gd == NULL)
    {
        printf("Erro ao alocar memória.");
        return;
    }
    fread(gd, sizeof(ext2_group_desc), 1, f);
    fseek(f, rel_inode*sizeof(ext2_inode) + BLOCKSIZE(sb->s_log_block_size)*gd->bg_inode_table, SEEK_SET);
    ext2_inode *inode = malloc(sizeof(ext2_inode));

    if(inode == NULL)
    {
        printf("Erro ao alocar memória.");
        return;
    }
    fread(inode, sizeof(ext2_inode), 1, f);
    for(int i=0;i < group_count*sb->s_inodes_per_group; i++){
        if(i_list[i] != 0){
            int bloco = -1;
            int seek = -1;
            int real_rec_len = -1;
            int var_aux = 0;
            freeSlot(f, sb, inode, &bloco, &seek, 16, &real_rec_len);
            ext2_dir_entry *dir = malloc(sizeof(ext2_dir_entry));
            if (dir == NULL){
                printf("Erro ao alocar memória.");
                return;
            }
            fread(&(dir->inode), sizeof(dir->inode), 1, f);
            fread(&(dir->rec_len), sizeof(dir->rec_len), 1, f);
            var_aux = dir->rec_len - real_rec_len;
            dir->rec_len = real_rec_len;
            fseek(f, inode->i_block[bloco] * BLOCKSIZE(sb->s_log_block_size) + seek + sizeof(dir->inode), SEEK_SET);
            fwrite(&(dir->rec_len), sizeof(dir->rec_len), 1, f);
            fseek(f, inode->i_block[bloco] * BLOCKSIZE(sb->s_log_block_size) + seek + real_rec_len, SEEK_SET);
            dir->inode = i + 1;
            dir->rec_len = var_aux;
            dir->file_type = 1;
            sprintf(dir->name, "#%d", i +1);
            dir->name_len = strlen(dir->name);
            fwrite(&(dir->inode), sizeof(dir->inode), 1, f);
            fwrite(&(dir->rec_len), sizeof(dir->rec_len), 1, f);
            fwrite(&(dir->name_len), sizeof(dir->name_len), 1, f);
            fwrite(&(dir->file_type), sizeof(dir->file_type), 1, f);
            fwrite(dir->name, sizeof(char), dir->name_len, f);
            free(dir);
        }
    }
    free(inode);
    free(gd);
}

void visitDir(FILE *f,ext2_inode *inode, ext2_super_block *sb, int *i_list, int group_count, int *found_inode){
	group_count = 1024;
    for(int j=0; j<inode->i_blocks/(2<<sb->s_log_block_size); j++){
	group_count++;
        fseek(f, inode->i_block[j] * BLOCKSIZE(sb->s_log_block_size), SEEK_SET);
        ext2_dir_entry *dir = malloc(sizeof(ext2_dir_entry));
        if (dir == NULL){
            printf("Erro ao alocar memória.");
            return;
        }
        int seek = 0;
	dir->inode = -1;
        while(seek < (BLOCKSIZE(sb->s_log_block_size)) && dir->inode !=0){
            if(dir->inode !=0){
                fread(&(dir->inode), sizeof(dir->inode), 1, f);
                fread(&(dir->rec_len), sizeof(dir->rec_len), 1, f);
                fread(&(dir->name_len), sizeof(dir->name_len), 1, f);
                fread(&(dir->file_type), sizeof(dir->file_type), 1, f);
                fread(dir->name, sizeof(char), dir->name_len, f);
                dir->name[dir->name_len] = '\0';
                if(strcmp(dir->name, "lost+found") == 0){
                    *found_inode = dir->inode -1;
                }
                seek += dir->rec_len;
                i_list[dir->inode - 1] = 0;
                fseek(f, inode->i_block[j] * BLOCKSIZE(sb->s_log_block_size) + seek, SEEK_SET);
            }
        }
        free(dir);
    }
}

void checkOrphans(FILE *f, int *i_list)
{
    ext2_super_block *sb = malloc(sizeof(ext2_super_block));
    if(sb == NULL)
    {
        printf("Erro ao alocar memória.");
        return;
    }

    fseek(f, BASE_OFFSET, SEEK_SET);
    fread(sb, sizeof(ext2_super_block), 1, f);
    int group_count = 1 + (sb->s_blocks_count-1) / sb->s_blocks_per_group;
    int found_inode = -1;
    for(int i = 0; i < group_count; i++)
    {
        fseek(f, i * sizeof(ext2_group_desc) + BLOCKSIZE(sb->s_log_block_size) + BASE_OFFSET, SEEK_SET);
        ext2_group_desc *gd = malloc(sizeof(ext2_group_desc));
        if(gd == NULL)
        {
            printf("Erro ao alocar memória.");
            return;
        }

        fread(gd, sizeof(ext2_group_desc), 1, f);
        fseek(f, BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_bitmap, SEEK_SET);

        char values[BLOCKSIZE(sb->s_log_block_size)];
        fread(values, sizeof(char), BLOCKSIZE(sb->s_log_block_size), f);
        for(int j = 0; j < sb->s_inodes_per_group; j++)
        {
            if(values[j/8]>>(j%8) & 1)
            {
                ext2_inode *inode = malloc(sizeof(ext2_inode));
                if(inode == NULL)
                {
                    printf("Erro ao alocar memória.");
                    return;
                }

                fseek(f, j*sizeof(ext2_inode) + BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_table, SEEK_SET);
                fread(inode, sizeof(ext2_inode), 1, f);
                if((inode->i_mode & EXT2_S_IFDIR) != 0 && inode->i_links_count != 0)
                {
                    visitDir(f, inode, sb, i_list, group_count, &found_inode);

                }

                fseek(f, (j+1)*sizeof(ext2_inode) + BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_table, SEEK_SET);

                free(inode);
            }
        }

        free(gd);
    }
    if(count_list(i_list, group_count*sb->s_inodes_per_group) !=0){
        printf("Foram encontrados arquivos orfaos. Deseja move-los para o diretorio /lost+found/?([Y]/Yes)([N]/No)\n");
        char answer;
        scanf("%c", &answer);
        while(answer != 'Y' && answer != 'N' ){
            printf("Digite uma resposta valida, por favor. ([Y]/Yes)([N]/No)");
            scanf("%c", &answer);
        }
        if(answer == 'Y'){
            replaceOrphans(f, found_inode, i_list, sb, group_count);
        }
    }
    free(sb);
}

void checkOrphanAttack(FILE *f)
{
    ext2_super_block *sb = malloc(sizeof(ext2_super_block));
    if(sb == NULL)
    {
        printf("Erro ao alocar memória.");
        return;
    }

    fseek(f, BASE_OFFSET, SEEK_SET);
    fread(sb, sizeof(ext2_super_block), 1, f);
    int group_count = 1 + (sb->s_blocks_count-1) / sb->s_blocks_per_group;
    int i_list[group_count*sb->s_inodes_per_group];
    for(int i=0; i< group_count*sb->s_inodes_per_group; i++){
        i_list[i] = 0;
    }
    for(int i = 0; i < group_count; i++)
    {
        fseek(f, i * sizeof(ext2_group_desc) + BLOCKSIZE(sb->s_log_block_size) + BASE_OFFSET, SEEK_SET);
        ext2_group_desc *gd = malloc(sizeof(ext2_group_desc));
        if(gd == NULL)
        {
            printf("Erro ao alocar memória.");
            return;
        }

        fread(gd, sizeof(ext2_group_desc), 1, f);
        fseek(f, BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_bitmap, SEEK_SET);

        char values[BLOCKSIZE(sb->s_log_block_size)];
        fread(values, sizeof(char), BLOCKSIZE(sb->s_log_block_size), f);
        for(int j = 0; j < sb->s_inodes_per_group; j++)
        {
            if(values[j/8]>>(j%8) & 1)
            {
                ext2_inode *inode = malloc(sizeof(ext2_inode));
                if(inode == NULL)
                {
                    printf("Erro ao alocar memória.");
                    return;
                }

                fseek(f, j*sizeof(ext2_inode) + BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_table, SEEK_SET);
                //printf("Inode %d: %d\n", i*sb->s_inodes_per_group+j, j*sizeof(ext2_inode) + BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_table);
                fread(inode, sizeof(ext2_inode), 1, f);

                if((inode->i_mode & EXT2_S_IFREG) != 0 && inode->i_links_count != 0)
                {
					if((i*sb->s_inodes_per_group + j) >= 11){
                    	i_list[i*sb->s_inodes_per_group+j] = 1;
					}
                }

                fseek(f, (j+1)*sizeof(ext2_inode) + BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_table, SEEK_SET);

                free(inode);
            }
        }

        free(gd);
    }
    checkOrphans(f, i_list);
    free(sb);
}

//remove inode do diretório, pois ele tem referência duplicada
void removeInodeFromDir(FILE *f, ext2_super_block *sb, long seekblock, int innum)
{
    int found = -1, count = 0, seek = 0;
    ext2_dir_entry *bckp = malloc((BLOCKSIZE(sb->s_log_block_size)/(sizeof(ext2_dir_entry) - MAX_FILENAME * sizeof(char)))*sizeof(ext2_dir_entry));
	if(bckp == NULL)
	{
		printf("Erro ao alocar memória.");
		return;
	}

    while(1)
    {
        fseek(f, seekblock + seek, SEEK_SET);
        readDir(f, &(bckp[count]), &seek);
        if(bckp[count].inode - 1 == innum)
        {
            found = count;
        }else if(seek == BLOCKSIZE(sb->s_log_block_size))
        {
            break;
        }
        count++;
    }

    fseek(f, seekblock, SEEK_SET);
    if(found == -1)
	{
		free(bckp);
		return;
	}
    else
    {
        int jmp = bckp[found].rec_len, i = 0;
		seek = 0;
        bckp[count].rec_len += jmp;
        for(; i <= count; i++)
        {
            if(i != found)
            {
				fseek(f, seekblock + seek, SEEK_SET);
                writeDir(f, &(bckp[i]));
				seek += bckp[i].rec_len;
            }
        }
    }

	free(bckp);
}

//anda pelos inodes nos níveis de indireção de um diretório
void walkOnInodeIndir(FILE *f, ext2_super_block *sb, int indir, long seek, int innum)
{
    int qtbl = BLOCKSIZE(sb->s_log_block_size)/4;
    __le32 blocks[qtbl];
    fread(blocks, sizeof(int), qtbl, f);

    for(int i = 0; i < qtbl; i++)
    {
        if(blocks[i] != 0)
        {
            if(indir == 0)
            {
                removeInodeFromDir(f, sb, seek, innum);
            }else
            {
                fseek(f, blocks[i] * BLOCKSIZE(sb->s_log_block_size), SEEK_SET);
                walkOnInodeIndir(f, sb, indir-1, blocks[i] * BLOCKSIZE(sb->s_log_block_size), innum);
            }
        }
    }
}


//procura os blocos indiretos de um diretório
void walkOnInodeDir(FILE *f, ext2_super_block *sb, ext2_inode *inode, int innum)
{
    for(int i = 12; i < 15; i++)
    {
        if(inode->i_block[i] != 0)
        {
            fseek(f, BLOCKSIZE(sb->s_log_block_size) * inode->i_block[i], SEEK_SET);
            walkOnInodeIndir(f, sb, i - 12, BLOCKSIZE(sb->s_log_block_size) * inode->i_block[i], innum);
        }
    }
}

//procura diretório do inode a ser removido
void removeFromDir(FILE *f, ext2_super_block *sb, int innum)
{
    int group_count = 1 + (sb->s_blocks_count-1) / sb->s_blocks_per_group;

    for(int i = 0; i < group_count; i++)
    {
        fseek(f, i * sizeof(ext2_group_desc) + BLOCKSIZE(sb->s_log_block_size) + BASE_OFFSET, SEEK_SET);
        ext2_group_desc *gd = malloc(sizeof(ext2_group_desc));
        if(gd == NULL)
        {
            printf("Erro ao alocar memória.\n");
            return;
        }

        fread(gd, sizeof(ext2_group_desc), 1, f);
        fseek(f, BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_bitmap, SEEK_SET);

        char values[BLOCKSIZE(sb->s_log_block_size)];
        fread(values, sizeof(char), BLOCKSIZE(sb->s_log_block_size), f);
        for(int j = 0; j < sb->s_inodes_per_group; j++)
        {
            if(values[j/8]>>(j%8) & 1)
            {
                ext2_inode *inode = malloc(sizeof(ext2_inode));
                if(inode == NULL)
                {
                    printf("Erro ao alocar memória.\n");
                    return;
                }

                fseek(f, j*sizeof(ext2_inode) + BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_table, SEEK_SET);
                fread(inode, sizeof(ext2_inode), 1, f);
                if(inode->i_links_count != 0 && ((inode->i_mode & EXT2_S_IFDIR) != 0))
                {
                    for(int k = 0; k < (inode->i_blocks/2 << BLOCKSIZE(sb->s_log_block_size)) && k < 13; k++)
                    {
                        if(k == 12)
                        {
                            walkOnInodeDir(f, sb, inode, innum);
                        }else if(inode->i_block[k] != 0)
                        {
                            removeInodeFromDir(f, sb, inode->i_block[k] * BLOCKSIZE(sb->s_log_block_size), innum);
                        }
                    }
                }

                free(inode);
            }
        }

        free(gd);
    }
}

//trata referência dupla invalidando o bitmap
void treateDoubleReferenceIndir(FILE *f, ext2_super_block *sb, int inodeNumber2)
{
    printf("Dupla referência à um bloco encontrada, deseja remover tal referência(o segundo inode será apagado)?(Sim [Y] e Não[N])\n");
    char aux;
    scanf("%c", &aux);
    if(aux == 'Y')
    {
        removeFromDir(f, sb, inodeNumber2);
        fseek(f, (inodeNumber2/sb->s_inodes_per_group) * sizeof(ext2_group_desc) + sizeof(ext2_super_block) + BASE_OFFSET , SEEK_SET);
        ext2_group_desc *auxgd = malloc(sizeof(ext2_group_desc));
        if(auxgd == NULL)
        {
            printf("Erro ao alocar memória.\n");
            return;
        }

        fread(auxgd, sizeof(ext2_group_desc), 1, f);
        fseek(f, BLOCKSIZE(sb->s_log_block_size) * auxgd->bg_inode_bitmap, SEEK_SET);

        char values[BLOCKSIZE(sb->s_log_block_size)];
        fread(values, sizeof(char), BLOCKSIZE(sb->s_log_block_size), f);

        int inode = inodeNumber2%sb->s_inodes_per_group;
        values[inode/(BYTE * sizeof(char))] &=  ~(1 << ((BYTE-1) - inode%(BYTE)));

        fseek(f, BLOCKSIZE(sb->s_log_block_size) * auxgd->bg_inode_bitmap, SEEK_SET);
        fwrite(values, sizeof(char), BLOCKSIZE(sb->s_log_block_size), f);

        free(auxgd);
    }
    scanf("%c", &aux);
}

//procura por dupla referência procurando nos diferentes níveis de indireção
void checkDoubleReferenceIndir(FILE *f, ext2_super_block *sb, int blockInode[], int indir, int inodeNumber)
{
    int qtbl = BLOCKSIZE(sb->s_log_block_size)/4;
    __le32 blocks[qtbl];
    fread(blocks, sizeof(int), qtbl, f);

    for(int i = 0; i < qtbl; i++)
    {
        if(blocks[i] != 0)
        {
            if(indir == 0)
            {
                if(blockInode[blocks[i]] == -1)
                {
                    blockInode[blocks[i]] = inodeNumber;
                }else
                {
                    treateDoubleReferenceIndir(f, sb, inodeNumber);
                }
            }else
            {
                if(blockInode[blocks[i]] == -1)
                {
                    blockInode[blocks[i]] = inodeNumber;
                }else
                {
                    treateDoubleReferenceIndir(f, sb, inodeNumber);
                }

                fseek(f, blocks[i] * BLOCKSIZE(sb->s_log_block_size), SEEK_SET);
                checkDoubleReferenceIndir(f, sb, blockInode, indir-1, inodeNumber);
            }
        }
    }
}

//procura os blocos indiretos de um inode qualquer
void checkDoubleReference(FILE *f, ext2_super_block *sb, ext2_inode *inode, int blockInode[], int inodeNumber)
{
    for(int i = 12; i < 15; i++)
    {
        if(inode->i_block[i] != 0)
        {
            fseek(f, BLOCKSIZE(sb->s_log_block_size) * inode->i_block[i], SEEK_SET);
            if(inode->i_block[i] != 0 && blockInode[inode->i_block[i]] == -1)
            {
                blockInode[inode->i_block[i]] = inodeNumber;
            }else if(inode->i_block[i] != 0)
            {
                treateDoubleReferenceIndir(f, sb, inodeNumber);
            }

            checkDoubleReferenceIndir(f, sb, blockInode, i - 12, inodeNumber);
        }
    }
}

//procura por problemas de dupla referência
void checkNotOneInodeAttack(FILE *f)
{
    ext2_super_block *sb = malloc(sizeof(ext2_super_block));
    if(sb == NULL)
    {
        printf("Erro ao alocar memória.\n");
        return;
    }

    fseek(f, BASE_OFFSET, SEEK_SET);
    fread(sb, sizeof(ext2_super_block), 1, f);
    int group_count = 1 + (sb->s_blocks_count-1) / sb->s_blocks_per_group;
    int blockInode[sb->s_blocks_count];
    for(int i = 0; i < sb->s_blocks_count; i++) blockInode[i] = -1;
    for(int i = 0; i < group_count; i++)
    {
        fseek(f, i * sizeof(ext2_group_desc) + BLOCKSIZE(sb->s_log_block_size) + BASE_OFFSET, SEEK_SET);
        ext2_group_desc *gd = malloc(sizeof(ext2_group_desc));
        if(gd == NULL)
        {
            printf("Erro ao alocar memória.\n");
            return;
        }

        fread(gd, sizeof(ext2_group_desc), 1, f);
        fseek(f, BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_bitmap, SEEK_SET);

        char values[BLOCKSIZE(sb->s_log_block_size)];
        fread(values, sizeof(char), BLOCKSIZE(sb->s_log_block_size), f);
        for(int j = 0; j < sb->s_inodes_per_group; j++)
        {
            if(values[j/8]>>(j%8) & 1)
            {
                ext2_inode *inode = malloc(sizeof(ext2_inode));
                if(inode == NULL)
                {
                    printf("Erro ao alocar memória.\n");
                    return;
                }

                fseek(f, j*sizeof(ext2_inode) + BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_table, SEEK_SET);
                fread(inode, sizeof(ext2_inode), 1, f);
                for(int k = 0; k < (inode->i_blocks/2 << BLOCKSIZE(sb->s_log_block_size)) && k < 13; k++)
                {
                    if(k == 12)
                    {
                        checkDoubleReference(f, sb, inode, blockInode, (i*sb->s_inodes_per_group + j));
                    }else
                    {
                        if(inode->i_block[k] != 0 && blockInode[inode->i_block[k]] == -1)
                        {
                            blockInode[inode->i_block[k]] = (i*sb->s_inodes_per_group + j);
                        }else if(inode->i_block[k] != 0)
                        {
                            treateDoubleReferenceIndir(f, sb, (i*sb->s_inodes_per_group + j));
                        }
                    }
                }
                free(inode);
            }
        }

        free(gd);
    }

    free(sb);
}

//converte a permissão do usuário
int getPermission(char permission[3])
{
    int newp = 0;
    for(int i = 0; i < 3; i++)
    {
        newp += (permission[i] - '0') << (2-i)*3;
    }

    return newp;
}

//trata erro de permissão
void treatePermissionError(FILE *f, ext2_inode *inode)
{
    printf("Encontrou-se o um bloco sem permissões deseja alterar as mesmas para um estado normal?(Sim [Y] e Não[N])\n");
    char aux;
    scanf("%c", &aux);
    if(aux == 'Y')
    {
        scanf("%c", &aux);
        printf("Digite os 3 dígitos da nova permissão(Exemplo: 777 ou 007) diferente de 000.\n");
        char permission[4];
        scanf("%s", permission);

        inode->i_mode |= (__le16)getPermission(permission);
	inode->i_mode |= EXT2_S_IFREG;
        fwrite(inode, sizeof(ext2_inode), 1, f);
    }

    scanf("%c", &aux);
}

//procura por ataque as permissões de um file
void checkPermissionAttack(FILE *f)
{
    ext2_super_block *sb = malloc(sizeof(ext2_super_block));
    if(sb == NULL)
    {
        printf("Erro ao alocar memória.");
        return;
    }

    fseek(f, BASE_OFFSET, SEEK_SET);
    fread(sb, sizeof(ext2_super_block), 1, f);

    int group_count = 1 + (sb->s_blocks_count-1) / sb->s_blocks_per_group;
    for(int i = 0; i < group_count; i++)
    {
        fseek(f, i * sizeof(ext2_group_desc) + BLOCKSIZE(sb->s_log_block_size) + BASE_OFFSET, SEEK_SET);
        ext2_group_desc *gd = malloc(sizeof(ext2_group_desc));
        if(gd == NULL)
        {
            printf("Erro ao alocar memória.");
            return;
        }

        fread(gd, sizeof(ext2_group_desc), 1, f);
        fseek(f, BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_bitmap, SEEK_SET);

        char values[BLOCKSIZE(sb->s_log_block_size)];
        fread(values, sizeof(char), BLOCKSIZE(sb->s_log_block_size), f);
        for(int j = 0; j < sb->s_inodes_per_group; j++)
        {
            if(values[j/8]>>(j%8) & 1)
            {
                ext2_inode *inode = malloc(sizeof(ext2_inode));
                if(inode == NULL)
                {
                    printf("Erro ao alocar memória.");
                    return;
                }

                fseek(f, j*sizeof(ext2_inode) + BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_table, SEEK_SET);
                fread(inode, sizeof(ext2_inode), 1, f);

                if((inode->i_mode & 0xfff) == 0 && inode->i_links_count != 0)
                {
                    fseek(f, j*sizeof(ext2_inode) + BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_table, SEEK_SET);
                    treatePermissionError(f, inode);
                }

                fseek(f, (j+1)*sizeof(ext2_inode) + BLOCKSIZE(sb->s_log_block_size) * gd->bg_inode_table, SEEK_SET);

                free(inode);
            }
        }

        free(gd);
    }

    free(sb);
}

//procura por ataques na img
void checkAttacks(FILE *f)
{
    checkSuperBlockAttack(f);
    checkNotOneInodeAttack(f);
    checkPermissionAttack(f);
    checkOrphanAttack(f);
}

int main(int argc, char** argv)
{
	//if(argc < 2) return -1;
    FILE *f10 = fopen("fs-0x00dcc605-ext2-10240.img", "r+b");
    if(f10 != NULL)
    {
        checkAttacks(f10);
        fclose(f10);
    }

    return (EXIT_SUCCESS);
}
