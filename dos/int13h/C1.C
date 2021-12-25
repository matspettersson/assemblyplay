#include <stdio.h>

extern int _testprint(char *);
extern int _readbootsector(void *);

int main(argc, argv, envp)
int argc;
char **argv;
char **envp;
 {
unsigned char * sector;
char test[10];
int n = 0;
int x;
int y;
int n1;

strcpy(test, "Hello\n\r$");
n = testprint(test);


sector = malloc(512);
n1 = readbootsector(sector);


for(x = 1; x <= 32; x++) {
   for(y = 0; y < 16; y++) {
	printf("%02x ", sector[(x*16)+y]);
	}
   printf("  ");
   for(y = 0; y < 16; y++) {
	printf("%c", sector[(x*16)+y]);
	}

   printf("\n");
   if(x % 10 == 0)
     gets();

}

free(sector);
printf("rc=%x\n", n1);
printf("Finished....\n");

}
