#include "types.h"
#include "user.h"

int stdout = 1;
int stderr = 2;

int
main(int argc, char *argv[])
{
    int va = 0x00000000;
    int ra =(int)(virt2real((char*)va));

    printf(stdout, "%d\n", (int)ra);
    exit();
}