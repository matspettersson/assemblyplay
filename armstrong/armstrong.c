#include <stdio.h>
#include <stdlib.h>

extern int checkarmstrong(int);

int main(int argc, char *argv[]) {

if(argc == 2) {
	int a = atoi(argv[1]);
	int b = checkarmstrong(a);
	printf("The number %d is armstrong: %d.\n", a, b);
	}
 else { 
	printf("Enter A or R + number...\n");
}

}
