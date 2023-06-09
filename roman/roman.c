#include <stdio.h>
#include <stdlib.h>

extern int romanToInt(char * );
extern int roman_to_int(char * );
extern int validate_roman_numeral(char * );
extern int fib(int );


int main(int argc, char *argv[]) {

if(argc == 2) {
	printf("Roman number: %s\n", argv[1]);
	// int rc = romanToInt(argv[1]);
	int rc = roman_to_int("XII");
	printf("rc=%d\n", rc);


	rc = validate_roman_numeral("XII");
	printf("rc validate=%d\n", rc);

} else { 
	printf("Enter roman number as parameter...\n");
}

}

