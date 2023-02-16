#include <stdio.h>
#include <stdlib.h>

int main()
{
    int array[] = {3, 4, 7, 1, 0, 1, 2, 5, 10, 12, -1, -120, 123, 1, -20, -42, 134};
    for (int i = 0; i < sizeof(array) / sizeof(int); i++)
        printf("%d ", array[i]);
    printf("\n");
    for (int i = 0; i < sizeof(array) / sizeof(int) - 1; i++)
    {
        for (int j = 0; j < sizeof(array) / sizeof(int) - i - 1; j++)
        {
            if (array[j] > array[j + 1])
            {
                int temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
    for (int i = 0; i < sizeof(array) / sizeof(int); i++)
        printf("%d ", array[i]);
    printf("\n");

    return 0;
}