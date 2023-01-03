#include <stdio.h>

#ifdef hellolin64
#define hellostr "Hello, world! Linux 64-bit :-)"
#endif

#ifdef hellowin64
#define hellostr "Hello, world! Windows 64-bit :-)"
#endif

#ifdef helloos216
#define hellostr "Hello, world! OS/2 16-bit :-)"
#endif

#ifdef helloos232
#define hellostr "Hello, world! OS/2 32-bit :-)"
#endif

#ifdef hellodos_l
#define hellostr "Hello, world! DOS Large memory model :-)"
#endif

#ifdef hellodos_s
#define hellostr "Hello, world! DOS Small memory model :-)"
#endif

#ifndef hellostr
#define hellostr "Hello, world! Default..."
#endif

extern int helloint(int );
extern int helloints(int , int , int , int , int , int , int , int , int );

int main() {
char *hello = hellostr;
int a;
int rc;
a = 0;
rc = 0;

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
