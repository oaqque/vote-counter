#include <stdio.h>
#include "tag_generation.h"

void print_byte_array(unsigned char byte_array[4]);

int main ()
{
    // Record input
    unsigned char D3 = 0;
    unsigned char D2 = 128;
    unsigned char D1 = 0;
    unsigned char D0 = 25;
    unsigned char input[4] = {D0, D1, D2, D3};
    print_byte_array(input);
    // Secret key
    int r3 = 3;
    int r2 = 3;
    int r1 = 2;
    int r0 = 2;
    int s = 3;
    int p2 = 4;
    int p1 = 5;
    int b2 = 2;
    int b1 = 1;
    
    // Tag generation algorithm
    *input = swap(input, s, p2, p1, b2, b1);
    print_byte_array(input);

    *input = rol(input, r3, r2, r1, r0);
    print_byte_array(input);

    unsigned char tag = xor(input);
    printf("==== TAG GENERATED ====\n");
    printf("%d\n", tag);

    return 0;
}

void print_byte_array(unsigned char byte_array[4])
{
    printf("---array---\n");
    int i = 3;
    while (i >= 0) {
        printf("%d\n", byte_array[i]);
        i--;
    }
    printf("-----------\n");
}