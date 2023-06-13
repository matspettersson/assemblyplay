#include <stdio.h>
#include <stdlib.h>

extern int arabicToStr(int);
// gdb --args roman X
// x/s $rdi
// p $rcx

int main(int argc, char *argv[]) {

if(argc == 2) {
	printf("Arabic number: %s\n", argv[1]);
	int a = atoi(argv[1]);
	int rc = arabicToStr(a);
	printf("rc=%d\n", rc);
	//rc = broman_to_int(argv[1]);
	//printf("rc=%d\n", rc);


//	rc = bvalidate_roman_numeral(argv[1]);
//	printf("rc validate=%d\n", rc);

} else { 
	printf("Enter arabic number as parameter...\n");
}

}

