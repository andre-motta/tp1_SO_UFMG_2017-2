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
    struct Node *next;
};


void clear()
{
 printf("\033[H\033[J"); 
}
void freeNodeList(struct Node* start)
{
    while(start->next->pid != 1)
    {
        struct Node *aux = start;
        start = start->next;
        //printf("Freed block of pid: %d\n", start->pid);
        free(start->data);
        free(start);

    }
    start = start->next;
   // printf("Freed block of pid: %d\n", start->pid);
    free(start->data);
    free(start);


}

/* Function to add a node at the beginning of Linked List.
   This function expects a pointer to the data to be added
   and size of the data type */
void push(struct Node** head_ref, struct dirent *new_data)
{
    size_t data_size = sizeof(struct dirent);
    // Allocate memory for node
    struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));

    new_node->data  = malloc(data_size);
    new_node->next = (*head_ref);

    // Copy contents of new_data to newly allocated memory.
    // Assumption: char takes 1 byte.
    new_node->data = new_data;

    // Change head pointer as new node is added at the beginning
    (*head_ref)    = new_node;
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
    struct Node *head;
    struct PID_LIST *list;
    FILE *current;
    //char *filename = malloc(7*sizeof(char));
    char filename[7] = "/proc/";
    struct dirent *input;
    
    
    while(1)
    {
        dp = opendir(filename);
        if (dp == NULL) 
        {
            perror("opendir");
            return -1;
        }
        while(input = readdir(dp))
        {
            if (input->d_name[0] == '0'||input->d_name[0] == '1'||input->d_name[0] == '2'||input->d_name[0] == '3'||input->d_name[0] == '4'||input->d_name[0] == '5'||input->d_name[0] == '6'||input->d_name[0] == '7'||input->d_name[0] == '8'||input->d_name[0] == '9')
            {
                
                push(&head, input);
                char* first_str = append(filename, head->data->d_name);
                char* final_str = append(first_str, "/stat");
                free(first_str);    
                current = fopen(final_str,"r");
                fscanf(current, "%d %s %c", &(head->pid), &garbage[0], &(head->status) );
                parse(garbage, &(head->name[0]));            
                stat(final_str, &(head->Stat));
                head->pwd = getpwuid(head->Stat.st_uid);
                fclose(current);
                free(final_str);
            }
        }
        closedir(dp);
        printf("|PID  | USER | NOME | STATUS| \n | -------- | ------- | ------- | -------| \n");
        int count =0;
        struct Node *print = head;
        do
        {
            printf("| %d |%s | %s | %c |\n ", print->pid, print->pwd->pw_name, print->name, print->status);
            print = print->next;
            count ++;
            if (print->pid == 1) {
                printf("| %d |%s | %s | %c |\n ", print->pid, print->pwd->pw_name, print->name, print->status);
                break;
            }
        }while(count < 20);
        freeNodeList(head);
           // sleep(3); 
            //clear();
            

    }

    
    free(filename);
    return 0;
}