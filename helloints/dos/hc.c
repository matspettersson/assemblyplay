#include <stdio.h>

extern int helloint(int );
extern int helloints(int , int , int , int , int , int , int , int , int );

/* int hellocints(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9) { */
int hellocints(a1, a2, a3, a4, a5, a6, a7, a8, a9) {  
/* int hellocints(int , int , int , int , int , int , int , int , int ) { */
	int ret;
	ret = 0;
	ret = a1;
	ret += a2;
	ret += a3;
	ret += a4;
	ret += a5;
	ret += a6;
	ret += a7;
	ret += a8;
	ret += a9;

	return ret;
}

int main() {
/*	int argc;
	char *argv[]; */
char *hello = "Hello, world! DOS 16-bit";
int a = 0;
int rc = 0;

	printf("%s\n",hello);

	a = 0;
	rc = helloint(a);
	printf("Return value: %d, Integer a = %d is %s\n", rc, a, rc ? "odd" : "even");
	a = 1;
	rc = helloint(a);
	printf("Return value: %d, Integer a = %d is %s\n", rc, a, rc ? "odd" : "even");
	a = 2;
	rc = helloint(a);
	printf("Return value: %d, Integer a = %d is %s\n", rc, a, rc ? "odd" : "even");
	a = 3;
	rc = helloint(a);
	printf("Return value: %d, Integer a = %d is %s\n", rc, a, rc ? "odd" : "even");
	a = 8;
	rc = helloint(a);
	printf("Return value: %d, Integer a = %d is %s\n", rc, a, rc ? "odd" : "even");
	rc = helloints(1, 2, 3, 4, 5, 6, 7, 8, 9);
	printf("rc=%d (%d %d %d %d %d %d %d %d %d)\n", rc, 1, 2, 3, 4, 5, 6, 7, 8, 9);
/*
	rc = hellocints(1, 2, 3, 4, 5, 6, 7, 8, 9);
	printf("crc=%d (%d %d %d %d %d %d %d %d %d)\n", rc, 1, 2, 3, 4, 5, 6, 7, 8, 9);
*/

	rc = helloints(1, 1, 1, 1, 1, 5, 0, 0, 0);
	printf("rc=%d (%d %d %d %d %d %d %d %d %d)\n", rc, 1, 1, 1, 1, 1, 5, 0, 0, 0);

	rc = helloints(9, 9, 9, 9, 10, 10, 10, 10, 10);
	printf("rc=%d (%d %d %d %d %d %d %d %d %d)\n", rc, 9, 9, 9, 9, 10, 10, 10, 10, 10);
/*
	rc = hellocints(1, 1, 1, 1, 1, 5, 0, 0, 0);
	printf("crc=%d\n", rc);
*/
}
