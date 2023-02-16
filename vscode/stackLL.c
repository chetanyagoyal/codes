#include <stdio.h>
#include <stdlib.h>

struct sll
{
    struct sll *next;
    int data;
};

void insertBegin(struct sll **head, int data)
{
    struct sll *newnode = (struct sll *)malloc(sizeof(struct sll));
    newnode->data = data;
    newnode->next = *head;
    *head = newnode;
}

void push(struct sll **head, int data)
{
    struct sll *newnode = (struct sll *)malloc(sizeof(struct sll));
    struct sll *temp = *head;

    while (temp->next != NULL)
    {
        temp = temp->next;
    }
    temp->next = newnode;
    newnode->next = NULL;
    newnode->data = data;
}

void pop(struct sll **head)
{
    struct sll *temp = *head;
    while (temp->next->next != NULL)
    {
        temp = temp->next;
    }
    temp->next = NULL;
}

void printStack(struct sll **head)
{
    struct sll *temp = *head;
    while (temp != NULL)
    {
        printf("%d ", temp->data);
        temp = temp->next;
    }
    printf("\n");
}

void swap(struct sll *a, struct sll *b)
{
    int temp;
    temp = a->data;
    a->data = b->data;
    b->data = temp;
}

void sortStack(struct sll **head)
{
    struct sll *a = *head;
    while (a->next != NULL)
    {
        struct sll *b;
        b = *head;
        while (b->next != NULL)
        {
            if (b->data > b->next->data)
                swap(b, b->next);
            b = b->next;
        }
        a = a->next;
    }
}
int main()
{
    struct sll *head = NULL;
    insertBegin(&head, 1);
    push(&head, 2);
    push(&head, -1);
    push(&head, 3);
    push(&head, 4);
    push(&head, 10);
    push(&head, -11);
    push(&head, 5);
    sort(&head);
    printStack(&head);
    return 0;
}