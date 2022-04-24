// Tag generation functions
unsigned char swap(unsigned char input[], int s, int p2, int p1, int b2, int b1);
unsigned char rol(unsigned char input[], int r3, int r2, int r1, int r0);
unsigned char xor(unsigned char input[]);

// Helper functions
unsigned char rol_byte(unsigned char x, int n);
unsigned char ror_byte(unsigned char x, int n);
void swap_byte(unsigned char * b2, unsigned char * b1, int size);
