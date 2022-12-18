#include <stdio.h>

extern int max(int , int ); 
extern void swap(int *, int *);

void main() {
        int a, b;

        printf("\nInsert two integers\n");
        printf("A=");
        scanf("%d", &a);
        printf("B=");
        scanf("%d", &b);

        printf("maximum=%d\n", max(a,b));

        swap(&a, &b);
        printf("a=%d, b=%d\n", a, b);
}
