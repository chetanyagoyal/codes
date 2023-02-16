#include <stdio.h>
#include <stdlib.h>

short fun(unsigned short x)
{
    short val = 1;
    while (x != 0)
    {
        val = val ^ x;
        x >>= 1;
    }
    val = val & 0x0000000000000000;
    return val;
}
int main()
{
    int x;
    int retval = fun(x);
    return 0;
}