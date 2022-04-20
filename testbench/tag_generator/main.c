#include <stdio.h>
#include <stdlib.h>
#include "tag_generation.h"

void print_byte_array(unsigned char byte_array[4]);

int main (int argc, char* argv[])
{
    if (argc != 5) {
        printf("Incorrect input count detected, 4 inputs expected\n");
        return EXIT_FAILURE;
    }

    // Record input
    unsigned char D3 = atoi(argv[1]);
    unsigned char D2 = atoi(argv[2]);
    unsigned char D1 = atoi(argv[3]);
    unsigned char D0 = atoi(argv[4]);
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

    return EXIT_SUCCESS;
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
