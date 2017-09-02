#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <dirent.h>
#include <pwd.h>



/* A linked list node */
struct Node
{
    struct dirent *data;
    struct stat Stat;
    int pid;
    char name[50];
    char status;
    char user[50];
    struct passwd *pwd;
    
};


void clear()
{
 printf("\033[H\033[J"); 
}


/* Function to print nodes in a given linked list. fpitr is used
   to access the function to be used for printing current node data.
   Note that different data types need different specifier in printf() */
char* append(char* head, char* tail)
{
    char* final_str;
    if((final_str = malloc(strlen(head)+strlen(tail)+1))!= NULL)
    {
        final_str[0] = '\0';
        strcat(final_str, head);
        strcat(final_str, tail);
        return final_str;

    }
}
void parse (char* origin, char* destination)
{
    int i;
    for(i = 1; i<strlen(origin); i++)
    {
       
        if (origin[i] != ')' && origin[i] != '/')
            {
                destination[i-1] = origin[i];
            }
            else 
            {
                destination[i-1] ='\0';
                return;
            }
    } 
}
int main (int argc, char **argv)
{
    char garbage[50];
    DIR *dp;
    struct PID_LIST *list;
    FILE *current;
    char filename[7] = "/proc/";
    struct dirent *input;
    int i =0;
    
    while(1)
    {
        dp = opendir(filename);
        if (dp == NULL) 
        {
            perror("opendir");
            return -1;
        }
        printf("|PID  | USER | NOME | STATUS| \n | -------- | ------- | ------- | -------| \n");
        int count =0;
        do
                {
        while(input = readdir(dp))
        {
            if (input->d_name[0] == '0'||input->d_name[0] == '1'||input->d_name[0] == '2'||input->d_name[0] == '3'||input->d_name[0] == '4'||input->d_name[0] == '5'||input->d_name[0] == '6'||input->d_name[0] == '7'||input->d_name[0] == '8'||input->d_name[0] == '9')
            {
                
                
                struct Node *head = malloc (sizeof(struct Node));                
                char* first_str = append(filename, input->d_name);
                char* final_str = append(first_str, "/stat");
                free(first_str);    
                current = fopen(final_str,"r");
                fscanf(current, "%d %s %c", &(head->pid), &garbage[0], &(head->status) );
                parse(garbage, &(head->name[0]));            
                stat(final_str, &(head->Stat));
                head->pwd = getpwuid(head->Stat.st_uid);
                printf("| %d |%s | %s | %c |\n ", head->pid, head->pwd->pw_name, head->name, head->status);
                count ++;
                fclose(current);
                free(head);
                free(final_str);
                if (count == 20) break;

               
            }
        }
                } while(count < 17);
        closedir(dp);
        
        
        sleep(1); 
        clear();
        i++;  

    }

    
    return 0;
}