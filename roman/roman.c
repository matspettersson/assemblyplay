#include <stdio.h>
#include <stdlib.h>

extern int romanToInt(char * );
extern int broman_to_int(char * );
extern int bvalidate_roman_numeral(char * );
// gdb --args roman X
// x/s $rdi
// p $rcx

int main(int argc, char *argv[]) {

if(argc == 2) {
	printf("Roman number: %s\n", argv[1]);
	int rc = romanToInt(argv[1]);
	printf("rc=%d\n", rc);
	//rc = broman_to_int(argv[1]);
	//printf("rc=%d\n", rc);


//	rc = bvalidate_roman_numeral(argv[1]);
//	printf("rc validate=%d\n", rc);

} else { 
	printf("Enter roman number as parameter...\n");
}

}

