#include <stdio.h>
#include <stdbool.h>

extern int helloint(int a);
extern int helloints(int , int , int , int , int , int , int , int , int );

int main(int argc, char *argv[]) {
char *hello = "Hello, world! Linux 64-bit";
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
	printf("rc=%d\n", rc);
	rc = helloints(1, 1, 1, 1, 1, 5, 0, 0, 0);
	printf("rc=%d\n", rc);
}
