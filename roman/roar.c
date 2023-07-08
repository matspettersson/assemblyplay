#include <stdio.h>
#include <stdlib.h>

extern char *arabicToString(int);
extern int romanToInt(char *);

int main(int argc, char *argv[]) {

if(argc == 3) {
	if(strcmp(argv[1], "A") == 0) {
		printf("Arabic number: %s\n", argv[2]);
		int a = atoi(argv[2]);
		char *str = arabicToString(a);
		printf("str=%s\n", str);
	}

	if(strcmp(argv[1], "R") == 0) {
		printf("Roman number: %s\n", argv[2]);
		int n  = romanToInt(argv[2]);
		printf("int=%d\n", n);
	}
} else { 
	printf("Enter A or R + number...\n");
}
}

