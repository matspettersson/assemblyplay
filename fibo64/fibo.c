#include <stdio.h>
#include <stdlib.h>

extern int fiboasm(int );
extern int fib(int );

int f(int x) {
	int retval;
	//printf("x=%d\n", x);
	if(x <= 1) {
		retval = x;
	} else {
		//printf("Else....\n");
		int x1 = f(x-1);
		int x2 = f(x-2);
		retval =  x1 + x2;
	}

	//printf("Retval=%d\n", retval);
	return retval;
}


int main(int argc, char *argv[]) {
int a = 0;
int f1;

	if(argc == 2)
		a = atoi(argv[1]);
	else
		a = 1;
/*
for(int n = 0; n < 20; n++) {
	f1 = f(n);
	printf("n=%d => %d\n", n, f1);
}
*/

/* int fx1 = fiboasm(1);
printf("aaa=%d => %d\n", 1, fx1);
int fx2 = fiboasm(2);
printf("bbb=%d => %d\n", 2, fx2); */
int fx3 = fib(3);
printf("ccc=%d => %d\n", 3, fx3);

for(int nn = 0; nn < 15; nn++) {
	int f2 = fib(nn);
	printf("n=%d => %d\n", nn, f2);
}

printf("0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610\n");
}
