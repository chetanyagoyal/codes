#include <stdio.h>
#include <stdlib.h>
#include <time.h>
struct node
{
    int data;
    struct node *next;
    struct node *prev;
};

void insertBegin(struct node **head, int data)
{
    struct node *newnode = (struct node *)malloc(sizeof(struct node));

    if (newnode != NULL)
    {

        if (*head == NULL)
        {
            newnode->next = NULL;
            newnode->prev = NULL;
            newnode->data = data;
            *head = newnode;
        }
        else
        {
            newnode->next = *head;
            newnode->prev = NULL;
            newnode->data = data;
            (*head)->prev = newnode;
            (*head) = newnode;
        }
        // printf("insertion success\n");
    }
}

void insertEnd(struct node **head, int data)
{
    struct node *temp;
    struct node *newnode = (struct node *)malloc(sizeof(struct node));
    if (*head == NULL)
    {
        newnode->next = NULL;
        newnode->prev = NULL;
        newnode->data = data;
        *head = newnode;
    }
    else
    {
        temp = *head;
        while (temp->next != NULL)
        {
            temp = temp->next;
        }
        temp->next = newnode;
        newnode->next = NULL;
        newnode->prev = temp;
        newnode->data = data;
    }
}

void insertMiddle(struct node **head, u_int16_t pos, int data)
{
    struct node *temp;
    struct node *newnode = (struct node *)malloc(sizeof(struct node));
    if (*head == NULL || pos == 0)
    {
        insertBegin(head, data);
    }
    else
    {
        temp = *head;
        for (u_int16_t i = 0; i < pos; i++)
        {
            temp = temp->next;
        }
        // printf("%d\n", temp->next->data);
        newnode->next = temp->next;
        newnode->prev = temp;
        temp->next = newnode;
        newnode->data = data;
    }
}
u_int16_t listSize(struct node **head)
{
    u_int16_t size = 0;
    struct node *temp;
    temp = *head;
    while (temp != NULL)
    {
        temp = temp->next;
        size++;
    }
    return size;
}
void printList(struct node **head)
{
    struct node *temp;
    temp = *head;
    u_int16_t size = listSize(head);
    while (temp != NULL)
    {
        printf("%d ", temp->data);
        temp = temp->next;
    }
    printf(", size = %d\n", size);
}
void deleteBegin(struct node **head)
{
    struct node *temp;
    temp = *head;
    temp = temp->next;
    temp->prev = NULL;
    *head = temp;
    printList(head);
}

void deleteEnd(struct node **head)
{
    struct node *temp;
    temp = *head;
    while (temp->next->next != NULL)
    {
        temp = temp->next;
    }
    // printf("%d\n", temp->data);
    temp->next = NULL;
    free(temp->next);
    printList(head);
}

void deleteMid(struct node **head, int pos)
{
    int size = listSize(head);
    if (size == pos + 2)
    {
        deleteEnd(head);
    }
    else if (pos == -1)
    {
        deleteBegin(head);
    }
    else
    {
        struct node *temp, *curr;
        temp = *head;
        for (int i = 0; i < pos; i++)
        {
            temp = temp->next;
        }
        curr = temp;
        temp->next = curr->next->next;
        curr->next->prev = temp;
        printList(head);
    }
}
void swap(struct node *a, struct node *b)
{
    int temp = a->data;
    a->data = b->data;
    b->data = temp;
}
void sortHL(struct node **head)
{
    struct node *i;
    i = *head;
    while (i->next != NULL)
    {
        struct node *j;
        j = *head;
        while (j->next != NULL)
        {
            if (j->data > j->next->data)
            {
                swap(j, j->next);
            }
            j = j->next;
        }
        i = i->next;
    }
}

int isSorted(struct node **head)
{
    struct node *i;
    i = *head;
    int sorted = 0;
    while (i->next != NULL)
    {
        struct node *j;
        j = *head;
        while (j->next != NULL)
        {
            if (j->data > j->next->data)
            {
                sorted++;
            }
            j = j->next;
        }
        i = i->next;
    }
    return sorted;
}
int main()
{
    struct node *head = NULL;
    srand(time(NULL));
    insertBegin(&head, 10);
    //printList(&head);
    for (int i = 0; i < 1000; i++)
    {
        insertMiddle(&head, 0, -25000 + rand() % 50000);
    }
    //printList(&head);
    sortHL(&head);
    //printList(&head);
    int flag = isSorted(&head);
    printf("sorted = %d\n", flag);
    return 0;
}