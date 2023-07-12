#include <stdio.h>
#include <stdlib.h>

extern int power(int, int);
extern int checkparm(char *);

int main(int argc, char *argv[]) {

if(argc == 3) {
	int a1 = atoi(argv[1]);
	int a2 = atoi(argv[2]);

	int a = power(a1, a2);		// 2 ^ 5
	printf("%d ^ %d = %d\n", a1, a2, a);

	char *s1 = "1234";
	int b = checkparm(s1);
	printf("str=%s, b=%d\n", s1, b);
	}

}
