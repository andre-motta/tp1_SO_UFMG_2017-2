#include "structs.h"


int attack1(char* arg){
    char garbage; 
    struct ext2_super_block sb;
    int fd = open(arg, O_RDWR);
    lseek(fd, BASE_OFFSET, SEEK_SET); 
    read(fd, &sb, sizeof(struct ext2_super_block));   
    
    if(sb.s_magic != EXT2_SUPER_MAGIC){
        lseek(fd, 1024 * 8193, SEEK_SET);
        read(fd, &sb, sizeof(struct ext2_super_block));
        if(sb.s_magic == EXT2_SUPER_MAGIC) {
            printf("Resolve attack 1?(y)\n");
            scanf("%c", &garbage); 
            lseek(fd, 1024, SEEK_SET);
            write(fd, &sb, sizeof(struct ext2_super_block));
            lseek(fd, 1024, SEEK_SET);
            read(fd, &sb, sizeof(struct ext2_super_block));
            return 0; 
        }
        else{
            printf("8193 not superblock\n");
        } 
        lseek(fd, 1024 * 16384, SEEK_SET);
        read(fd, &sb, sizeof(struct ext2_super_block));
        if(sb.s_magic == EXT2_SUPER_MAGIC) {
            printf("Resolve attack 1?(y)\n");
            scanf("%c", &garbage); 
            lseek(fd, 1024, SEEK_SET);
            write(fd, &sb, sizeof(struct ext2_super_block));
            lseek(fd, 1024, SEEK_SET);
            read(fd, &sb, sizeof(struct ext2_super_block));
            return 0; 
        }
        else{
            printf("16384 not superblock\n");
        }
        lseek(fd, 1024 * 32768, SEEK_SET);
        read(fd, &sb, sizeof(struct ext2_super_block));
        if(sb.s_magic == EXT2_SUPER_MAGIC) {
            printf("Resolve attack 1?(y)\n");
            scanf("%c", &garbage); 
            lseek(fd, 1024, SEEK_SET);
            write(fd, &sb, sizeof(struct ext2_super_block));
            lseek(fd, 1024, SEEK_SET);
            read(fd, &sb, sizeof(struct ext2_super_block));
            return 0; 
        }
        else{
            printf("32768 not superblock\n");
        } 
    }
    
    return 0;
}

int attack2(int fd, int offset, unsigned char* bitmap, struct ext2_inode inode, int* array, int inode_num, int pos, int block_size){
   if(inode.i_mode == 0 && inode.i_blocks == 0) return 0;
    int i, j, backup;
	backup = fd;
    char garbage;
    for(int i = 0; i<inode_num; i++){         
        
        if(array[i] == inode.i_block[0]){
            printf("Resolve attack 2?(y)\n");
            scanf("%c", &garbage);
            scanf("%c", &garbage);
            scanf("%c", &garbage); 
            bitmap[pos] ^= (0x01 << (7-inode_num%8));
			lseek(fd, offset, SEEK_SET);
			write(fd, bitmap, block_size);
	    array[inode_num] = -1;
	    printf("Removendo inode duplicado %d referenciando inode %d\n", inode_num+1, i+1); 
		fd = backup;
        return 0;
        }
	 }
	 fd = backup;
     array[inode_num] = inode.i_block[0];
   	 return 1;	
}

int attack3(struct ext2_inode inode, int fd, int inode_num, int inode_tb_add)
{
	int backup, permission =0;
	backup = fd;
	lseek(fd, inode_num*sizeof(struct ext2_inode) + inode_tb_add, SEEK_SET);
	read(fd, &inode, sizeof(struct ext2_inode));
	
	if((inode.i_mode & 0xff) == 0 )
	{
		if(inode.i_links_count == 0) return -1;	
		inode.i_mode |= S_IFREG;
		printf("Type in CHMOD modifier format xyz (x = other, y=group, z=owner)\n");
		scanf("%d", &permission);
		inode.i_mode |= permission;
		backup = fd;
		lseek(fd, inode_num*sizeof(struct ext2_inode) + inode_tb_add, SEEK_SET);
		write(fd, &inode, sizeof(struct ext2_inode));
		fd = backup; 		
	}
	fd = backup;
	return inode_num;

}

int attack4(struct ext2_inode inode, int inode_num, int real_num,  int* table, int lostFound, int inode_address, int fd, int block_size)
{

	
	char garbage;
	int i, acc = 0, free = -1, cur_size = -1, seek = -1, aux = 0;
	int lrec_len;
	int backup = fd;
	if(!table[inode_num]){
			printf("Resolver ataque 4? (y)\n");
			scanf("%c",&garbage);
			scanf("%c",&garbage);
			struct ext2_inode lostfoundinode;
			struct ext2_dir_entry2 dir;
			lseek(fd, inode_address + (lostFound*sizeof(struct ext2_inode)), SEEK_SET); 
			read(fd, &lostfoundinode, sizeof(struct ext2_inode));
			for(i=0; i<12; i++)
			{
				while(acc < block_size)
				{
					lseek(fd, lostfoundinode.i_block[i]*block_size + acc, SEEK_SET);
					read(fd, &dir.inode, sizeof(dir.inode));
					read(fd, &dir.rec_len, sizeof(dir.rec_len));
					read(fd, &dir.name_len, sizeof(dir.name_len));
					read(fd, &dir.file_type, sizeof(dir.file_type));
					read(fd, dir.name, sizeof(char)*dir.name_len);
					dir.name[dir.name_len] = '\0';
					acc += dir.rec_len;
					
					if(dir.inode == 0)
					{
						free = i;
						seek = acc;
						lrec_len = sizeof(dir.inode) + sizeof(dir.name_len) + sizeof(dir.rec_len) + sizeof(dir.file_type) + dir.name_len;
						cur_size = lrec_len + (lrec_len%4 != 0 ? (4-lrec_len%4) : 0);
						acc = block_size;
					}
				}
			}
			lseek(fd, lostfoundinode.i_block[i]*block_size + seek, SEEK_SET);
			read(fd, &dir.inode, sizeof(dir.inode));
			read(fd, &dir.rec_len, sizeof(dir.rec_len));
			aux = dir.rec_len - cur_size;
			dir.rec_len = cur_size;
			lseek(fd, lostfoundinode.i_block[i]*block_size + seek + sizeof(dir.inode), SEEK_SET);
			write(fd, &dir.rec_len, sizeof(dir.rec_len));
			dir.inode = real_num + 1;
			dir.rec_len = aux;
			dir.file_type = 1;
			sprintf(dir.name, "#%d", real_num+1);
			dir.name_len = strlen(dir.name);
			write(fd, &dir.inode, sizeof(dir.inode));
			write(fd, &dir.rec_len, sizeof(dir.rec_len));
			write(fd, &dir.name_len, sizeof(dir.name_len));
			write(fd, &dir.file_type, sizeof(dir.file_type));
			write(fd, dir.name, sizeof(char)*dir.name_len);

			
	}
	fd = backup;
	
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
	//printf("-------------------- BLOCO %d ------------------\n", block);
	int offset = group_offset + (inode.i_block[block]*block_size);
	while(1)
	{
		//printf("offset = %d  e vai ate %lu\n", accumulator, block_size - sizeof(struct ext2_dir_entry2));
		//printf("acummulator b4= %d\n", accumulator);
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
		//printf("acummulator after= %d blocksize = %d\n", accumulator, block_size);
		//scanf("%c", &garbage);
		//printf("read file %s of inode %d namesize %d and size %d\n", dir.name, dir.inode, dir.name_len, dir.rec_len);
		if(dir.inode != 0)
		{
			//printf("inode %d referenciado no sistema\n", dir.inode);
			table[dir.inode-1] = 1;	
		}
		if(checkname(dir.name))
		{	
			
			lost_found = dir.inode -1;
			//printf("lost+found = %d\n", lost_found);
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
		//printf("\n\n------------------ GROUP %d -------------------\n\n", l);

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
			//if(i<30) printf("inode %d imode %d\n", inode_num+1, inode.i_mode);
			if((bitmap[i/8] >> (i%8) & 1)){
				//printf("inode %d lido bloco = %d\n", inode_num + 1, inode.i_block[0]);
				//printf("Inode %d must be checked\n", inode_num +1);
				valid[i] = attack2(fd, i_bmap_address, bitmap, inode, array, i, i/8, block_size);
			}
			//printf("ciclo do for de attack2\n");            
        }
		
		for(i = 0; i<(sb.s_inodes_per_group); i++){
			
			inode_num = i + l*sb.s_inodes_per_group;
        	lseek(fd, inode_address +(i*sizeof(struct ext2_inode)), SEEK_SET);
			read(fd, &inode, sizeof(struct ext2_inode));
			if(valid[i]){
				//printf("valid inode file mode %d, isdir %d inode size %d, inode num %d\n", inode.i_mode, S_ISDIR(inode.i_mode), inode.i_size, inode_num+1);
				attack3(inode, fd, i, inode_address);
				
			}
			if(S_ISDIR(inode.i_mode) && (inode.i_links_count != 0)&&(bitmap[i/8] >> (i%8) & 1)){	
					//printf("inode %d is dir \n", i + 1);
					lostfound = findReferences(inode, inode_num, fd,  inode_address, group_offset, block_size, &n, table);
					
				}
		}
		for (i=0; i<30; i++)
			{
				//printf("inode %d = %d (1 is referenced 0 is ghost inode)\n", i+1, table[i]);
			}
		int aux=0;
		for(i = 0; i<(sb.s_inodes_per_group); i++){
			inode_num = i + l*sb.s_inodes_per_group;
        	lseek(fd, inode_address +(i*sizeof(struct ext2_inode)), SEEK_SET);
			read(fd, &inode, sizeof(struct ext2_inode));
			if(valid[i] && inode_num > 10){
				 attack4(inode,  i,   inode_num,   table,  lostfound, inode_address, fd, block_size);

			}
		}
    }
    return 0;
}

int main(int argc, char **argv){   
  	fsck(argv[1]);
	
    return 0;
}
