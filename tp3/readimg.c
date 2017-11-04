#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/types.h>
#include <sys/stat.h>
#include <linux/magic.h>
#include <asm/byteorder.h>
#include "attack2.c"

#define BASE_OFFSET 1024

int main(int argc, char **argv){   
    fsck(argv[1]);
    return 0;
}
