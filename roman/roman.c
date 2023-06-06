#include <stdio.h>
#include <stdlib.h>

extern int romanToInt(char * );
extern int fib(int );


int main(int argc, char *argv[]) {

if(argc == 2) {
	printf("Roman number: %s\n", argv[1]);
	int rc = romanToInt(argv[1]);
	printf("rc=%d\n", rc);
} else { 
	printf("Enter roman number as parameter...\n");
}

}

