#include <stdio.h>
#include "tag_generation.h"

unsigned char swap(unsigned char input[], int s, int p2, int p1, int b2, int b1) 
{
    printf("Executing swap function...\n");
    printf("b2 %d: %d\n", b2, input[b2]);
    printf("b1 %d: %d\n", b1, input[b1]);
    // Rotate the byte to the correct position
    input[b2] = ror_byte(input[b2], p2);
    input[b1] = ror_byte(input[b1], p1);
    printf("Rotating right b2 by %d: %d\n", p2, input[b2]);
    printf("Rotating right b1 by %d: %d\n", p1, input[b1]);

    // Conduct swap of size s
    printf("Swapping b2 and b1...\n");
    swap_byte(&input[b2], &input[b1], s);
    printf("b2 %d: %d\n", b2, input[b2]);
    printf("b1 %d: %d\n", b1, input[b1]);

    input[b2] = rol_byte(input[b2], p2);
    input[b1] = rol_byte(input[b1], p1);
    printf("Rotating left b2 by %d: %d\n", p2, input[b2]);
    printf("Rotating left b1 by %d: %d\n", p1, input[b1]);

    printf("Completed swap function...\n");
    return *input;
}

unsigned char rol(unsigned char input[], int r3, int r2, int r1, int r0)
{
    printf("Executing ROL function...\n");
    input[0] = rol_byte(input[0], r0);
    input[1] = rol_byte(input[1], r1);
    input[2] = rol_byte(input[2], r2);
    input[3] = rol_byte(input[3], r3);
    printf("Completed ROL function...\n");
    return *input;
}

unsigned char xor(unsigned char input[])
{
    unsigned char tag = input[0] ^ input[1] ^ input[2] ^ input[3];
    return tag; 
}

unsigned char ror_byte(unsigned char x, int n)
{
    unsigned char temp = x << (8 - n);
    x = (x >> n) & 0xFF;
    return x | temp;
}

unsigned char rol_byte(unsigned char x, int n)
{
    unsigned char temp = (x << n) & 0xFF;
    x = x >> (8 - n);
    return temp | x;
}

void swap_byte(unsigned char * b2, unsigned char * b1, int size)
{
    int i = 0;
    while (i < size) 
    {
        unsigned char mask = 1u << i;
        unsigned char tmp_b2 = *b2, tmp_b1 = *b1;
        unsigned char bitdiff = tmp_b2 ^ tmp_b1;
        bitdiff &= mask;
        *b2 = tmp_b2 ^ bitdiff;
        *b1 = tmp_b1 ^ bitdiff;
        i++;
    }
}