#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

struct queue
{
    struct queue *next;
    struct queue *prev;
    int data;
};

void enqueue(struct queue **front, struct queue **back, int data)
{
    struct queue *q = (struct queue*)malloc(sizeof(struct queue));
    q->data = data;
    if (*front == NULL)
    {
        q->next == NULL;
        q->prev == NULL;
        *front->next = q;
        q = *front;
    }
}

int main()
{
    struct queue *front == NULL;
    struct queue *back == NULL;
}