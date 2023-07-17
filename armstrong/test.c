#include <stdio.h>
#include <stdlib.h>

extern int power(int, int);
extern int armstrong(int);
extern int checkparm(char *);
extern int power_sse(int, int);

int main(int argc, char *argv[]) {

if(argc == 2) {
	int a = atoi(argv[1]);
	int c = armstrong(a);
	printf("number=%d --- armstrong: %d\n", a, c);

}

if(argc == 3) {
	int a1 = atoi(argv[1]);
	int a2 = atoi(argv[2]);

	int a = power(a1, a2);		// 2 ^ 5
	printf("%d ^ %d = %d\n", a1, a2, a);

	char *s1 = "1234";
	int b = checkparm(s1);
	printf("str=%s, b=%d\n", s1, b);

	int sse1 = a1;
	int sse2 = a2;
	unsigned long int ps = power_sse(sse1, sse2);
	printf("sse %d ^ %d = %d\n", a1, a2, a);


	}

}
