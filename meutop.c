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



/* A linked list node */
struct Node
{
    struct dirent *data;

    struct Node *next;
};

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

int main (int argc, char **argv)
{
    DIR *dp;
    struct Node *head;   

    struct dirent *input;
    dp = opendir(".");
    if (dp == NULL) 
    {
        perror("opendir");
        return -1;
    }
    while(input = readdir(dp))
        push(&head, input);
    
    closedir(dp);

    return 0;
}