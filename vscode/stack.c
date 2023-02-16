#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_ITEMS 10

struct stack
{
    int items[MAX_ITEMS];
    int top;
    int num_elem;
};

void create(struct stack *s)
{
    s->top = -1;
    s->num_elem = 0;
}

int isFull(struct stack *s)
{
    if (s->top == MAX_ITEMS - 1)
    {
        return 1;
    }
    else
        return 0;
}

bool isEmpty(struct stack *s)
{
    if (s->top == -1)
    {
        s->num_elem = 0;
        return 1;
    }
    else
        return 0;
}

void push(struct stack *s, int data)
{
    if (!isFull(s))
    {
        s->top++;
        s->items[s->top] = data;
        s->num_elem++;
    }
    else
        printf("stack full");
}

void pop(struct stack *s)
{
    if (!isEmpty(s))
    {
        s->top--;
        s->num_elem--;
    }
}

void printStack(struct stack *s)
{
    for (int i = 0; i < s->num_elem; i++)
    {
        printf("%d ", s->items[i]);
    }
    printf("\ntop_elem = %d\n", s->items[s->top]);
}
int main()
{
    struct stack *s1 = (struct stack *)malloc(sizeof(struct stack));

    create(s1);
    if (isEmpty(s1))
        push(s1, 1);
    printStack(s1);
    push(s1, 2);
    printStack(s1);
    push(s1, 3);
    printStack(s1);
    pop(s1);
    printStack(s1);

    return 0;
}