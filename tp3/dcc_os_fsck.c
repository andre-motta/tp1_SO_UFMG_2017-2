#include "structs.h"


int attack1(char* arg){
    char answer;
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
            scanf("%c", &answer);
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
            scanf("%c", &answer);
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
            scanf("%c", &answer);
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
   if(inode.i_mode == 0 && inode.i_blocks != 0) return 1;
   if(inode.i_mode == 0 && inode.i_blocks == 0) return 0;
    int i, j, backup;
    char answer;
    for(int i = 0; i<inode_num; i++){
        //printf("inode block %d == array[%d] %d\n", inode.i_block[0], i, array[i]);
         
        
        if(array[i] == inode.i_block[0]){
            printf("Resolve attack 2?(y)\n");
            scanf("%c", &answer);
            bitmap[pos] ^= (0x01 << (inode_num%8));
	    //NEW (ZEROES THE INODE)
	    for(i=0; j<15; j++)
		    inode.i_block[i] = 0;
	    inode.i_blocks = 0;
	    inode.i_mode = 0;
	    //
            backup = fd;
	    lseek(fd, offset, SEEK_SET);
	    write(fd, bitmap, block_size);
	    //NEW (WRITES THE INODE IN THE DATA OFFSETS TO I_BITMAP THEN JUMPS 1 BLOCK + THE NUMBER OF BLOCKS UNTIL YOUR INODE)
	    lseek(fd, offset + (block_size * (inode_num +1)), SEEK_SET);
	    write(fd, &inode, sizeof(struct ext2_inode);
            //
	    fd = backup;
	    array[inode_num] = -1;
	    //printf("removing duplicate inode %d referencing inode %d\n", inode_num+1, i+1); 
            return 0;
        }
	 }
	 //printf("inode num valido %d\n", inode_num+1);
     array[inode_num] = inode.i_block[0];
   	 return 1;	
}

int attack3(struct ext2_inode inode, int fd, int inode_num, int offset)
{
	//printf("mode inicial = %u\n", inode.i_mode);
	int backup, permission =0;
	backup = fd;
	lseek(fd, inode_num*sizeof(struct ext2_inode) + offset, SEEK_SET);
	read(fd, &inode, sizeof(struct ext2_inode));
	fd = backup;
	if((inode.i_mode & 0xff) == 0 )
	{
		//printf("entrou no attack3 case\n");
		if(inode.i_links_count == 0) return -1;	
		inode.i_mode += S_IFREG;
		printf("Type in CHMOD modifier format xyz (x = other, y=group, z=owner)\n");
		scanf("%d", &permission);
		inode.i_mode += permission;
		backup = fd;
		lseek(fd, inode_num*sizeof(struct ext2_inode) + offset, SEEK_SET);
		write(fd, &inode, sizeof(struct ext2_inode));
		fd = backup; 		
	}
	
//	printf("mode final = %u\n", inode.i_mode);
	return 0;

}
int attack4(struct ext2_inode inode, int inode_num, int* table, int lostFound, int sizetable)
{
	int i;
	for (i=0; i<sizetable; i++)
	{
		if(inode_num == table[i]){}
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
 
int findReferences(struct ext2_inode inode, int inode_num, int fd, int inode_offset, int group_offset, int block_size, int* pos, int* table)
{
	int blockLostFound = 0;
	struct ext2_dir_entry dir;
	struct ext2_inode inode_ind;
	int backup = fd;
	int vector1[block_size/sizeof(int)];
	int vector2[block_size/sizeof(int)];
	int vector3[block_size/sizeof(int)];
	int i, j, k, l;
	for(i=0; i<inode.i_blocks; i++)
	{
		if (i < 12)
		{
			if(inode.i_block[i] != 0)
			{
				lseek(fd, inode.i_block[i]*block_size + group_offset + BASE_OFFSET, SEEK_SET);
				read(fd, &dir, sizeof(struct ext2_dir_entry));

				fillTable(dir.inode, pos, table);
			}
		}
		if (i == 12)
		{
			if(inode.i_block[i] != 0)
			{
				lseek(fd, inode.i_block[i]*block_size + group_offset + BASE_OFFSET, SEEK_SET);
				read(fd, &vector1, sizeof(block_size));
				for(j=0; j<block_size/sizeof(int); j++)
				{
					if(vector1[j] != 0)
					{
						lseek(fd, vector1[j]*block_size + group_offset + BASE_OFFSET, SEEK_SET);
						read(fd, &dir, sizeof(struct ext2_dir_entry));
						fillTable(dir.inode, pos, table);
					}
				}
			}
		}
		if (i == 13)
		{
			if(inode.i_block[i] != 0)
			{
				lseek(fd, inode.i_block[i]*block_size + group_offset + BASE_OFFSET, SEEK_SET);
				read(fd, &vector1, sizeof(block_size));
				for(j=0; j<block_size/sizeof(int); j++)
				{
					if(vector1[j] != 0)
					{
						lseek(fd, vector1[j]*block_size + group_offset + BASE_OFFSET, SEEK_SET);
						read(fd, &vector2, sizeof(block_size));
						for(k=0; k<block_size/sizeof(int); k++)
						{
							if (vector2[k] != 0)
							{
								lseek(fd, vector2[k]*block_size + group_offset + BASE_OFFSET, SEEK_SET);
								read(fd, &dir, sizeof(struct ext2_dir_entry));
								fillTable(dir.inode, pos, table);
							}
						}		
					}
				}
			}
		}
		if (i == 14)
		{
			if(inode.i_block[i] != 0)
			{
				lseek(fd, inode.i_block[i]*block_size + group_offset + BASE_OFFSET, SEEK_SET);
				read(fd, &vector1, sizeof(block_size));
				for(j=0; j<block_size/sizeof(int); j++)
				{
					if(vector1[j] != 0)
					{
						lseek(fd, vector1[j]*block_size + group_offset + BASE_OFFSET, SEEK_SET);
						read(fd, &vector2, sizeof(block_size));
						for(k=0; k<block_size/sizeof(int); k++)
						{
							if(vector2[k] != 0)
							{
								lseek(fd, vector2[k]*block_size + group_offset + BASE_OFFSET, SEEK_SET);
								read(fd, &vector3, sizeof(block_size));
								for(l=0; l<block_size/sizeof(int); l++)
								{	
									if(vector3[l] != 0)
									{
										lseek(fd, vector3[l]*block_size + group_offset + BASE_OFFSET, SEEK_SET);
										read(fd, &dir, sizeof(struct ext2_dir_entry));
										fillTable(dir.inode, pos, table);
									}	
								}
							}
						}		
					}
				}
			}
		}
	}
	fd = backup;
	return blockLostFound;
}

int fsck(char* arg){
    attack1(arg);
    struct ext2_super_block sb;
    int fd = open(arg, O_RDWR);
    lseek(fd, BASE_OFFSET, SEEK_SET);
    read(fd, &sb, sizeof(struct ext2_super_block));
   // printf("magic number sb = %d\n", sb.s_magic);
    //block size
    unsigned int block_size = 1024 << sb.s_log_block_size;

    unsigned int group = 1 + (sb.s_blocks_count-1) / sb.s_blocks_per_group;
    unsigned int group_offset;
    //number of block groups on the disk
    
    //size of group descriptor list in bytes
    unsigned int descr_list_size = group * sizeof(struct ext2_group_desc);
    
    struct ext2_group_desc gd;
    struct ext2_inode inode; 
    int i, j, k, l;
    for(l=0; l<group; l++){
        group_offset = block_size * l * sb.s_blocks_per_group;
        //set head above group descriptor block
        lseek(fd, BASE_OFFSET + group_offset + block_size, SEEK_SET);
  //      printf("group_offset = %d\n", group_offset);
        read(fd, &gd, sizeof(struct ext2_group_desc));
    //    printf("free blocks group = %d\n", gd.bg_free_blocks_count);
        int i_bmap_address = BASE_OFFSET * gd.bg_block_bitmap + group_offset + BASE_OFFSET;
        unsigned char *bitmap;
        bitmap = malloc(block_size); 
        lseek(fd, i_bmap_address, SEEK_SET);
        read(fd, bitmap, block_size); //read bitmap

        int array[sb.s_inodes_per_group];
		int table[sb.s_inodes_per_group];
        for (i=0; i<sb.s_inodes_per_group; i++)
		{
			array[i] = -1;
			table[i] =  0;
		}
		int lostfound;
		int valid[sb.s_inodes_per_group]; 
        int inode_address = BASE_OFFSET + group_offset + (gd.bg_inode_table * block_size); 
        lseek(fd, inode_address, SEEK_SET);
        for(i = 0; i<(sb.s_inodes_per_group/8); i++){
            for(j = 0; j<8; j++){
                read(fd, &inode, sizeof(struct ext2_inode));
                if((bitmap[i] >> j) & 0x01){
                    int inode_num = i*8 + j;
//                    printf("inode file mode %d, inode size %d, inode num %d\n", inode.i_mode, inode.i_size, inode_num+1);
                    
                    valid[inode_num] = attack2(fd, i_bmap_address, bitmap, inode, array, inode_num, i, block_size);
                }
            }
        }
		lseek(fd, inode_address, SEEK_SET);
		int n =0;
		for(i=0; i<(sb.s_inodes_per_group/8); i++){
         	for(j=0; j<8; j++){
				read(fd, &inode, sizeof(struct ext2_inode));
				int inode_num = i*8 + j;
				if(valid[inode_num]){
                	attack3(inode, fd, inode_num, inode_address);
                    if(S_ISDIR(inode.i_mode)){		
						lostfound = findReferences(inode, inode_num, fd,  inode_address, group_offset, block_size, &n, table);
					}
                }
			}
		}
		lseek(fd, inode_address, SEEK_SET);
		for(i=0; i<(sb.s_inodes_per_group/8); i++){
         	for(j=0; j<8; j++){
				read(fd, &inode, sizeof(struct ext2_inode));
				int inode_num = i*8 + j;
				if(valid[inode_num]){
					attack4(inode, inode_num, table, lostfound, sb.s_inodes_per_group);
				}
			}
		}
		
        free(bitmap);
    }
    return 0;
}

int main(int argc, char **argv){   
  	fsck(argv[1]);
	fsck(argv[1]);
	
    return 0;
}
