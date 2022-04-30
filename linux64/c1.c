#include <stdio.h>
#include <string.h>

int mats(char *str) {
    printf("%s\n", str);
    return strlen(str);
}


int main(int argc, char *argv[]) {
char retstr[3];
char *ret;
unsigned char ch;
int a = 0;
int rc = 0;

/*
	ch = 'a';
	ret = hexdisp(&ch); */
	//ret = hexdisp("abcdefghijk");

/*
  rc = slen(argv[1]); */
  rc = mats("Hello world");
	printf("Return value: %d\n", rc);

}
