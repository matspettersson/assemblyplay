#include <stdio.h>
#include <stdlib.h>

extern char *arabicToString(int);
extern int romanToInt(char *);
// gdb --args roman X
// x/s $rdi
// p $rcx

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
/*
char *s0 = "CMIV";
char *s1 = "IV";
char *s2 = "MDMCCIV";
char *s3 = "VIII";
printf("%s = %d\n", s0, romanToInt(s0));
printf("%s = %d\n", s1, romanToInt(s1));

printf("%s = %d\n", s2, romanToInt(s2));
printf("%s = %d\n", s3, romanToInt(s3));
*/
}

