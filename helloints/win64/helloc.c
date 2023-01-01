#include <stdio.h>

extern int helloint(int a);
extern int helloints(int , int , int , int , int , int , int , int , int );

int main(int argc, char *argv[]) {
char *hello = "Hello, world! Windows 64-bit";
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


	rc = helloints(1, 1, 1, 1, 1, 5, 0, 0, 0);
	printf("rc=%d (%d %d %d %d %d %d %d %d %d)\n", rc, 1, 1, 1, 1, 1, 5, 0, 0, 0);

	rc = helloints(9, 9, 9, 9, 10, 10, 10, 10, 10);
	printf("rc=%d (%d %d %d %d %d %d %d %d %d)\n", rc, 9, 9, 9, 9, 10, 10, 10, 10, 10);

}
