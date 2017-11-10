#include "structs.h"


int attack1(char* arg){
    char garbage; 
    struct ext2_super_block sb;
    int fd = open(arg, O_RDWR);
    lseek(fd, BASE_OFFSET, SEEK_SET); 
    read(fd, &sb, sizeof(struct ext2_super_block));   
  //  printf("magic = %d\n", sb.s_magic);
    
    if(sb.s_magic != EXT2_SUPER_MAGIC){
		//printf("Recovering superblock\n");
        lseek(fd, 1024 * 8193, SEEK_SET);
        read(fd, &sb, sizeof(struct ext2_super_block));
        if(sb.s_magic == EXT2_SUPER_MAGIC) {
            //printf("magic = %d\n", sb.s_magic);
            printf("Resolve attack 1?(y)\n");
            scanf("%c", &garbage); 
            lseek(fd, 1024, SEEK_SET);
            write(fd, &sb, sizeof(struct ext2_super_block));
            lseek(fd, 1024, SEEK_SET);
            read(fd, &sb, sizeof(struct ext2_super_block));
            //printf("magic final = %d\n", sb.s_magic);
            return 0; 
        }
        else{
            //printf("8 not superblock\n");
        } 
        lseek(fd, 1024 * 16384, SEEK_SET);
        read(fd, &sb, sizeof(struct ext2_super_block));
        if(sb.s_magic == EXT2_SUPER_MAGIC) {
        //    printf("magic = %d\n", sb.s_magic);
            printf("Resolve attack 1?(y)\n");
            scanf("%c", &garbage); 
            lseek(fd, 1024, SEEK_SET);
            write(fd, &sb, sizeof(struct ext2_super_block));
            lseek(fd, 1024, SEEK_SET);
            read(fd, &sb, sizeof(struct ext2_super_block));
       //     printf("magic final = %d\n", sb.s_magic);
            return 0; 
        }
        else{
            //printf("16 not superblock\n");
        }
        lseek(fd, 1024 * 32768, SEEK_SET);
        read(fd, &sb, sizeof(struct ext2_super_block));
        if(sb.s_magic == EXT2_SUPER_MAGIC) {
     //       printf("magic = %d\n", sb.s_magic);
            printf("Resolve attack 1?(y)\n");
            scanf("%c", &garbage); 
            lseek(fd, 1024, SEEK_SET);
            write(fd, &sb, sizeof(struct ext2_super_block));
            lseek(fd, 1024, SEEK_SET);
            read(fd, &sb, sizeof(struct ext2_super_block));
            //printf("magic final = %d\n", sb.s_magic);
            return 0; 
        }
        else{
            //printf("32 not superblock\n");
        } 
    }
    
    return 0;
}

int attack2(int fd, int offset, unsigned char* bitmap, struct ext2_inode inode, int* array, int inode_num, int pos, int block_size){
   if(inode.i_mode == 0 && inode.i_blocks == 0) return 0;
   printf("Entrou no attack 2\n");
    int i, j, backup;
	backup = fd;
    char garbage;
    for(int i = 0; i<inode_num; i++){
        	printf("inode %d block %d == array[%d] %d ?????\n",inode_num+1, inode.i_block[0], i, array[i]);
         
        
        if(array[i] == inode.i_block[0]){
            printf("Resolve attack 2?(y)\n");
            scanf("%c", &garbage);
            scanf("%c", &garbage);
            scanf("%c", &garbage); 
            bitmap[pos] ^= (0x01 << (7-inode_num%8));
			lseek(fd, offset, SEEK_SET);
			write(fd, bitmap, block_size);
	    array[inode_num] = -1;
	    printf("removing duplicate inode %d referencing inode %d\n", inode_num+1, i+1); 
		fd = backup;
        return 0;
        }
	 }
	 fd = backup;
	 printf("inode num valido %d\n", inode_num+1);
     array[inode_num] = inode.i_block[0];
   	 return 1;	
}

int attack3(struct ext2_inode inode, int fd, int inode_num, int inode_tb_add)
{
	printf("mode inicial = %u, inode %d\n", inode.i_mode, inode_num+1);
	int backup, permission =0;
	backup = fd;
	lseek(fd, inode_num*sizeof(struct ext2_inode) + inode_tb_add, SEEK_SET);
	read(fd, &inode, sizeof(struct ext2_inode));
	
	if((inode.i_mode & 0xff) == 0 )
	{
		printf("entrou no attack3 case\n");
		printf("Attack3 achou inode %d tinha modo %d\n", inode_num +1, inode.i_mode);
		if(inode.i_links_count == 0) return -1;	
		inode.i_mode |= 0x8000;
		printf("Type in CHMOD modifier format xyz (x = other, y=group, z=owner)\n");
		scanf("%d", &permission);
		inode.i_mode |= permission;
		printf("NEW MODE = %d\n", inode.i_mode);
		backup = fd;
		lseek(fd, inode_num*sizeof(struct ext2_inode) + inode_tb_add, SEEK_SET);
		write(fd, &inode, sizeof(struct ext2_inode));
		fd = backup; 		
	}
	fd = backup;
//	printf("mode final = %u\n", inode.i_mode);
	return inode_num;

}
int attack4(struct ext2_inode inode, int inode_num, int real_num,  int* table, int lostFound, int sizetable)
{

	if(!table[inode_num]){
			printf("inode % is lost\n", real_num+1);
		
			//Teoricamente os inodes orfãos seriam encontrados aqui, contudo algo de errado ocorreu.
	}
	
}

int fillTable(int inode, int* pos, int *table)
{
	int i;
	for(i=0; i<(*pos); i++)
	{
		if(inode == table[(i)]);
			return -1;
	}
	table[(*pos)] = inode;
	*pos ++;
	return 0;
	
}
int checkname(char* name)
{
	int result = 1;
	if ((name[0] != 'l') || (name[1] != 'o') || (name[2] != 's') || (name[3] != 't')|| (name[4] != '+'))
		result = 0;

	return result ;
}
int findRefInBlock(int block, struct ext2_inode inode,  int  inode_id, int fd, int group_offset, int block_size,  int* table )
{
	char garbage;
	int lost_found = 0;
	struct ext2_dir_entry2 dir;
	int accumulator = 0;
	printf("-------------------- BLOCO %d ------------------\n", block);
	int offset = group_offset + (inode.i_block[block]*block_size);
	while(1)
	{
		printf("offset = %d  e vai ate %lu\n", accumulator, block_size - sizeof(struct ext2_dir_entry2));
		printf("acummulator b4= %d\n", accumulator);
		lseek(fd, offset + accumulator, SEEK_SET);
		read(fd, &dir.inode, sizeof(dir.inode));
		if(dir.inode == 0){
			break;
		}
		read(fd, &dir.rec_len, sizeof(dir.rec_len));
		read(fd, &dir.name_len, sizeof(dir.name_len));
		read(fd, &dir.file_type, sizeof(dir.file_type));
		read(fd, dir.name, sizeof(char)*dir.name_len);
		dir.name[dir.name_len] = '\0';
		accumulator += dir.rec_len;
		printf("acummulator after= %d blocksize = %d\n", accumulator, block_size);
		scanf("%c", &garbage);
		printf("read file %s of inode %d namesize %d and size %d\n", dir.name, dir.inode, dir.name_len, dir.rec_len);
		if(dir.inode != 0)
		{
			printf("inode %d referenciado no sistema\n", dir.inode);
			table[dir.inode-1] = 1;	
		}
		if(checkname(dir.name))
		{	
			
			lost_found = dir.inode -1;
		}
		if (accumulator >= block_size) 
		{
			accumulator = 0;
			break;
		}	
	}
	
	return lost_found;

}
int findReferences(struct ext2_inode inode, int inode_num, int fd, int inode_offset, int group_offset, int block_size, int* pos, int* table)
{
	int blockLostFound = 0;
	int backup = fd;
	int i;
	for(i=0; i<12; i++)
	{
		findRefInBlock(i, inode ,inode_num +1, fd, group_offset, block_size, table);
	}
	fd = backup;
	return blockLostFound;
}

int fsck(char* arg){
    attack1(arg);
	int inode_num = 0;
    struct ext2_super_block sb;
    int fd = open(arg, O_RDWR);
    lseek(fd, BASE_OFFSET, SEEK_SET);
    read(fd, &sb, sizeof(struct ext2_super_block));

    unsigned int block_size = 1024 << sb.s_log_block_size;
    unsigned int group = 1 + (sb.s_blocks_count-1) / sb.s_blocks_per_group;
    unsigned int group_offset;
    unsigned int descr_list_size = group * sizeof(struct ext2_group_desc);
    
    struct ext2_group_desc gd;
    struct ext2_inode inode; 
    int i, j, k, l;
    for(l=0; l<group; l++){
		inode_num = 0;
		printf("\n\n------------------ GROUP %d -------------------\n\n", l);

        group_offset =  l *sizeof(struct ext2_group_desc);

        lseek(fd, BASE_OFFSET + group_offset + block_size, SEEK_SET);
        read(fd, &gd, sizeof(struct ext2_group_desc));

        int i_bmap_address = block_size * gd.bg_inode_bitmap;

        unsigned char bitmap[block_size];

        lseek(fd, i_bmap_address, SEEK_SET);
        read(fd, &bitmap, block_size); 

        int array[sb.s_inodes_per_group];
		int table[sb.s_inodes_per_group];
		int valid[sb.s_inodes_per_group]; 

        for (i=0; i<sb.s_inodes_per_group; i++)
		{
			array[i] = -1;
			table[i] =  0;
			valid[i] =  0;
		}
		int lostfound;
        int inode_address = (gd.bg_inode_table * block_size); 
	int n = 0;

        for(i = 0; i<(sb.s_inodes_per_group); i++){
			inode_num = i + l*sb.s_inodes_per_group;
			lseek(fd, inode_address +(i*sizeof(struct ext2_inode)), SEEK_SET);
			read(fd, &inode, sizeof(struct ext2_inode));
			if(i<30) printf("inode %d imode %d\n", inode_num+1, inode.i_mode);
			if((bitmap[i/8] >> (i%8) & 1)){
				printf("inode %d lido bloco = %d\n", inode_num + 1, inode.i_block[0]);
				printf("Inode %d must be checked\n", inode_num +1);
				valid[i] = attack2(fd, i_bmap_address, bitmap, inode, array, i, i/8, block_size);
			}
			//printf("ciclo do for de attack2\n");            
        }
		
		for(i = 0; i<(sb.s_inodes_per_group); i++){
			
			inode_num = i + l*sb.s_inodes_per_group;
        	lseek(fd, inode_address +(i*sizeof(struct ext2_inode)), SEEK_SET);
			read(fd, &inode, sizeof(struct ext2_inode));
			if(valid[i]){
				printf("valid inode file mode %d, isdir %d inode size %d, inode num %d\n", inode.i_mode, S_ISDIR(inode.i_mode), inode.i_size, inode_num+1);
				attack3(inode, fd, i, inode_address);
				
			}
			if(S_ISDIR(inode.i_mode) && (inode.i_links_count != 0)&&(bitmap[i/8] >> (i%8) & 1)){	
					printf("inode %d is dir \n", i + 1);
					lostfound = findReferences(inode, inode_num, fd,  inode_address, group_offset, block_size, &n, table);
				}
		}
		for (i=0; i<30; i++)
			{
				printf("inode %d = %d (1 is referenced 0 is ghost inode)\n", i+1, table[i]);
			}
		for(i = 0; i<(sb.s_inodes_per_group); i++){
			inode_num = i + l*sb.s_inodes_per_group;
        	lseek(fd, inode_address +(i*sizeof(struct ext2_inode)), SEEK_SET);
			read(fd, &inode, sizeof(struct ext2_inode));
			if(valid[i] && inode_num > 10){
				 attack4( inode,  i,   inode_num,   table,  lostfound, sb.s_inodes_per_group);

			}
		}
    }
    return 0;
}

int main(int argc, char **argv){   
  	fsck(argv[1]);
	
    return 0;
}
