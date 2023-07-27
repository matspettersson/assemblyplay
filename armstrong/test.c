#include <stdio.h>
#include <stdlib.h>

extern int armstrong(int);

int main(int argc, char *argv[]) {

if(argc == 2) {
	int a = atoi(argv[1]);
	unsigned int c = armstrong(a);
	if(c == 0) {
		printf("%d is an Armstrong number.\n", a);
	} else {
		printf("%d is not an Armstrong number.\n", a);
	}
}

}