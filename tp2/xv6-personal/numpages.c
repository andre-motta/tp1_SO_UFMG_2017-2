#include "types.h"
#include "user.h"

int stdout = 1;
int stderr = 2;

int
main(int argc, char *argv[])
{
    int pages = numpages();
    if(pages < 0){
        printf(stderr, "Erro na chamada de sistema\n");
        exit(); 
    } 

    printf(stdout, "%d\n", pages);
    exit();
}
