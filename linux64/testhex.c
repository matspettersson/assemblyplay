#include <stdio.h>
#include <stdbool.h>

//extern char * hexdisp(unsigned char a);
extern char * hexdisp(char * a);
extern int slen(char * a);

int main(int argc, char *argv[]) {
char retstr[3];
char *ret;
unsigned char ch;
int a = 0;
int rc = 0;


	ch = 'a';
	//ret = hexdisp(&ch);
	ret = hexdisp("Hello world! Oi mundo!\n");


  rc = slen(argv[1]);
	printf("Return value: %d\n", rc);



}
