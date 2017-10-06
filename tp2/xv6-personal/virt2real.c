#include "types.h"
#include "user.h"
#include "memlayout.h"

int stdout = 1;
int stderr = 2;

int
main(int argc, char *argv[])
{
    int va = PHYSTOP;
    int ra =(int)(virt2real((char*)va));

    printf(stdout, "%d\n", (int)ra);
    exit();
}
