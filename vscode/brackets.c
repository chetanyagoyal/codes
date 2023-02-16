#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define MAX_ITEMS 10

struct stack
{
    char items[MAX_ITEMS];
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

void push(struct stack *s, char data)
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
        printf("%c ", s->items[i]);
    }
    printf("\ntop_elem = %c\n", s->items[s->top]);
}

int main()
{
    struct stack *br = (struct stack *)malloc(sizeof(struct stack));
    create(br);
    int success = 1;
    char inp[10] = {'<', '[', '(', '{', '}', ')', ']', '>'};
    for (int i = 0; i < sizeof(inp) / sizeof(char); i++)
    {
        if (inp[i] == '<' || inp[i] == '(' || inp[i] == '[' || inp[i] == '{')
            push(br, inp[i]);
        else if (inp[i] == '>' || inp[i] == ')' || inp[i] == ']' || inp[i] == '}')
        {
            char a[1] = {br->items[br->top]};
            char b[1] = {inp[i]};
            printf("%c %c\n", br->items[br->top], inp[i]);
            if (strcmp(a, b))
            {
                pop(br);
            }
            else
                success = 0;
        }
    }
    printStack(br);
    for (int i = 0; i < sizeof(inp) / sizeof(char); i++)
    {
        printf("%c ", inp[i]);
    }
    printf("success = %d\n", success);

    return 0;
}