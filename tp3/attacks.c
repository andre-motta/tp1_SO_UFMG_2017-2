#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/types.h>
#include <sys/stat.h>
#include <linux/magic.h>
#include <asm/byteorder.h>

#define BASE_OFFSET 1024
#define EXT2_NDIR_BLOCKS        12
#define EXT2_IND_BLOCK          EXT2_NDIR_BLOCKS
#define EXT2_DIND_BLOCK         (EXT2_IND_BLOCK + 1)
#define EXT2_TIND_BLOCK         (EXT2_DIND_BLOCK + 1)
#define EXT2_N_BLOCKS   (EXT2_TIND_BLOCK + 1)

/*
 * Structure of the super block
 */
struct ext2_super_block {
    __le32  s_inodes_count;     /* Inodes count */
    __le32  s_blocks_count;     /* Blocks count */
    __le32  s_r_blocks_count;   /* Reserved blocks count */
    __le32  s_free_blocks_count;    /* Free blocks count */
    __le32  s_free_inodes_count;    /* Free inodes count */
    __le32  s_first_data_block; /* First Data Block */
    __le32  s_log_block_size;   /* Block size */
    __le32  s_log_frag_size;    /* Fragment size */
    __le32  s_blocks_per_group; /* # Blocks per group */
    __le32  s_frags_per_group;  /* # Fragments per group */
    __le32  s_inodes_per_group; /* # Inodes per group */
    __le32  s_mtime;        /* Mount time */
    __le32  s_wtime;        /* Write time */
    __le16  s_mnt_count;        /* Mount count */
    __le16  s_max_mnt_count;    /* Maximal mount count */
    __le16  s_magic;        /* Magic signature */
    __le16  s_state;        /* File system state */
    __le16  s_errors;       /* Behaviour when detecting errors */
    __le16  s_minor_rev_level;  /* minor revision level */
    __le32  s_lastcheck;        /* time of last check */
    __le32  s_checkinterval;    /* max. time between checks */
    __le32  s_creator_os;       /* OS */
    __le32  s_rev_level;        /* Revision level */
    __le16  s_def_resuid;       /* Default uid for reserved blocks */
    __le16  s_def_resgid;       /* Default gid for reserved blocks */
    /*
     * These fields are for EXT2_DYNAMIC_REV superblocks only.
     *
     * Note: the difference between the compatible feature set and
     * the incompatible feature set is that if there is a bit set
     * in the incompatible feature set that the kernel doesn't
     * know about, it should refuse to mount the filesystem.
     * 
     * e2fsck's requirements are more strict; if it doesn't know
     * about a feature in either the compatible or incompatible
     * feature set, it must abort and not try to meddle with
     * things it doesn't understand...
     */
    __le32  s_first_ino;        /* First non-reserved inode */
    __le16   s_inode_size;      /* size of inode structure */
    __le16  s_block_group_nr;   /* block group # of this superblock */
    __le32  s_feature_compat;   /* compatible feature set */
    __le32  s_feature_incompat;     /* incompatible feature set */
    __le32  s_feature_ro_compat;    /* readonly-compatible feature set */
    __u8    s_uuid[16];     /* 128-bit uuid for volume */
    char    s_volume_name[16];  /* volume name */
    char    s_last_mounted[64];     /* directory where last mounted */
    __le32  s_algorithm_usage_bitmap; /* For compression */
    /*
     * Performance hints.  Directory preallocation should only
     * happen if the EXT2_COMPAT_PREALLOC flag is on.
     */
    __u8    s_prealloc_blocks;  /* Nr of blocks to try to preallocate*/
    __u8    s_prealloc_dir_blocks;  /* Nr to preallocate for dirs */
    __u16   s_padding1;
    /*
     * Journaling support valid if EXT3_FEATURE_COMPAT_HAS_JOURNAL set.
     */
    __u8    s_journal_uuid[16]; /* uuid of journal superblock */
    __u32   s_journal_inum;     /* inode number of journal file */
    __u32   s_journal_dev;      /* device number of journal file */
    __u32   s_last_orphan;      /* start of list of inodes to delete */
    __u32   s_hash_seed[4];     /* HTREE hash seed */
    __u8    s_def_hash_version; /* Default hash version to use */
    __u8    s_reserved_char_pad;
    __u16   s_reserved_word_pad;
    __le32  s_default_mount_opts;
    __le32  s_first_meta_bg;    /* First metablock block group */
    __u32   s_reserved[190];    /* Padding to the end of the block */
};

struct ext2_group_desc
{
  __le32 bg_block_bitmap;         /* Blocks bitmap block */
  __le32 bg_inode_bitmap;         /* Inodes bitmap block */
  __le32 bg_inode_table;          /* Inodes table block */
  __le16 bg_free_blocks_count;    /* Free blocks count */
  __le16 bg_free_inodes_count;    /* Free inodes count */
  __le16 bg_used_dirs_count;      /* Directories count */
  __le16 bg_pad;
  __le32 bg_reserved[3];
};

/*
 * Structure of an inode on the disk
 */
struct ext2_inode {
    __le16  i_mode;     /* File mode */
    __le16  i_uid;      /* Low 16 bits of Owner Uid */
    __le32  i_size;     /* Size in bytes */
    __le32  i_atime;    /* Access time */
    __le32  i_ctime;    /* Creation time */
    __le32  i_mtime;    /* Modification time */
    __le32  i_dtime;    /* Deletion Time */
    __le16  i_gid;      /* Low 16 bits of Group Id */
    __le16  i_links_count;  /* Links count */
    __le32  i_blocks;   /* Blocks count */
    __le32  i_flags;    /* File flags */
    union {
        struct {
            __le32  l_i_reserved1;
        } linux1;
        struct {
            __le32  h_i_translator;
        } hurd1;
        struct {
            __le32  m_i_reserved1;
        } masix1;
    } osd1;             /* OS dependent 1 */
    __le32  i_block[EXT2_N_BLOCKS];/* Pointers to blocks */
    __le32  i_generation;   /* File version (for NFS) */
    __le32  i_file_acl; /* File ACL */
    __le32  i_dir_acl;  /* Directory ACL */
    __le32  i_faddr;    /* Fragment address */
    union {
        struct {
            __u8    l_i_frag;   /* Fragment number */
            __u8    l_i_fsize;  /* Fragment size */
            __u16   i_pad1;
            __le16  l_i_uid_high;   /* these 2 fields    */
            __le16  l_i_gid_high;   /* were reserved2[0] */
            __u32   l_i_reserved2;
        } linux2;
        struct {
            __u8    h_i_frag;   /* Fragment number */
            __u8    h_i_fsize;  /* Fragment size */
            __le16  h_i_mode_high;
            __le16  h_i_uid_high;
            __le16  h_i_gid_high;
            __le32  h_i_author;
        } hurd2;
        struct {
            __u8    m_i_frag;   /* Fragment number */
            __u8    m_i_fsize;  /* Fragment size */
            __u16   m_pad1;
            __u32   m_i_reserved2[2];
        } masix2;
    } osd2;             /* OS dependent 2 */
};

int attack1(char* arg){
    struct ext2_super_block sb;
    int fd = open(arg, O_RDWR);
    lseek(fd, BASE_OFFSET, SEEK_SET); 
    read(fd, &sb, sizeof(struct ext2_super_block));   
  //  printf("magic = %d\n", sb.s_magic);
    
    if(sb.s_magic != EXT2_SUPER_MAGIC){
		printf("Recovering superblock\n");
        lseek(fd, 1024 * 8193, SEEK_SET);
        read(fd, &sb, sizeof(struct ext2_super_block));
        if(sb.s_magic == EXT2_SUPER_MAGIC) {
            printf("magic = %d\n", sb.s_magic);
            lseek(fd, 1024, SEEK_SET);
            write(fd, &sb, sizeof(struct ext2_super_block));
            lseek(fd, 1024, SEEK_SET);
            read(fd, &sb, sizeof(struct ext2_super_block));
            printf("magic final = %d\n", sb.s_magic);
            return 0; 
        }
        else{
            printf("8 not superblock\n");
        } 
        lseek(fd, 1024 * 16384, SEEK_SET);
        read(fd, &sb, sizeof(struct ext2_super_block));
        if(sb.s_magic == EXT2_SUPER_MAGIC) {
        //    printf("magic = %d\n", sb.s_magic);
            lseek(fd, 1024, SEEK_SET);
            write(fd, &sb, sizeof(struct ext2_super_block));
            lseek(fd, 1024, SEEK_SET);
            read(fd, &sb, sizeof(struct ext2_super_block));
       //     printf("magic final = %d\n", sb.s_magic);
            return 0; 
        }
        else{
            printf("16 not superblock\n");
        }
        lseek(fd, 1024 * 32768, SEEK_SET);
        read(fd, &sb, sizeof(struct ext2_super_block));
        if(sb.s_magic == EXT2_SUPER_MAGIC) {
     //       printf("magic = %d\n", sb.s_magic);
            lseek(fd, 1024, SEEK_SET);
            write(fd, &sb, sizeof(struct ext2_super_block));
            lseek(fd, 1024, SEEK_SET);
            read(fd, &sb, sizeof(struct ext2_super_block));
            printf("magic final = %d\n", sb.s_magic);
            return 0; 
        }
        else{
            printf("32 not superblock\n");
        } 
    }
    
    return 0;
}

int attack2(int, int, unsigned char* bitmap, struct ext2_inode inode, int* array, int inode_num, int pos, int block_size);
int attack3(struct ext2_inode, int, int, int);

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
        for (i=0; i<sb.s_inodes_per_group; i++)
		{
			array[i] = -1;
		}
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
		for(i=0; i<(sb.s_inodes_per_group/8); i++){
         	for(j=0; j<8; j++){
				read(fd, &inode, sizeof(struct ext2_inode));
				int inode_num = i*8 + j;
				if(valid[inode_num]){
                	        attack3(inode, fd, inode_num, inode_address);
                        	//attack4(inode, inode_num);
                }
			}
		}

        free(bitmap);
    }
    return 0;
}



int attack2(int fd, int offset, unsigned char* bitmap, struct ext2_inode inode, int* array, int inode_num, int pos, int block_size){
   if(inode.i_mode == 0 && inode.i_blocks != 0) return 1;
   if(inode.i_mode == 0 && inode.i_blocks == 0) return 0;
    int i, backup;
    for(int i = 0; i<inode_num; i++){
        //printf("inode block %d == array[%d] %d\n", inode.i_block[0], i, array[i]);
         
        
        if(array[i] == inode.i_block[0]){
            bitmap[pos] ^= (0x01 << (inode_num%8));
            backup = fd;
	        lseek(fd, offset, SEEK_SET);
	   		write(fd, bitmap, block_size);
	        fd = backup;
		    array[inode_num] = -1;
			printf("removing duplicate inode %d referencing inode %d\n", inode_num+1, i+1); 
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

int attack4(struct ext2_inode inode, int inode_num, int fd, int offset)
{
	return 0;
}
