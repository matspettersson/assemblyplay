#include <stdio.h>

extern int _mp1(int, int, char *);
extern int _testprint(char *);
extern int _readbootsector(void *);
extern unsigned char * _allocmem();

extern int _getsegoff(long *, long *, unsigned char *);

typedef unsigned int size_t;

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
char tmp;
unsigned char *ptr;
int add;
long	segment = 3;
long	offset = 4;
long ln = 0;

printf("sizeof int: %d\n", sizeof(int));
printf("sizeof long int: %d\n", sizeof(long));


strcpy(test, "Hello\n\r$");
n = testprint(test);

/*
sector = malloc(1024);
*/

sector = allocmem();
printf("address: %x\n", sector);
printf("rc: %ld - Segment: %ld, offset: %ld\n", ln, segment, offset);

strcpy(sector, "Mats1234567890ABCDEF");
ln = getsegoff(&segment, &offset, sector);
printf("rc: %ld - Segment: %ld, offset: %ld (%#x)\n", ln, segment, offset, offset);

/*
mp1(&segment, &offset, sector);
*/


add = (int)sector;
printf("add(1): %d\n", add);
printf("add%16: %d\n", add % 16);
add = add - (add % 16);

printf("add(2): %d\n", add);
ptr = (unsigned char *)(add);

ptr = sector;

printf("Address to sector: %x\n", ptr);
n1 = readbootsector(ptr);

for(x = 0; x < 32; x++) {
   for(y = 0; y < 16; y++) {
	printf("%02x ", ptr[(x*16)+y]);
	}
   printf("  ");
   for(y = 0; y < 16; y++) {
	tmp = ptr[(x*16) + y];
	if(tmp == 13)
	  tmp = ' ';
	if(tmp == 10)
	  tmp = ' ';	
	printf("%c", tmp);
	}

   printf("\n");
   if((x>0) && (x % 10 == 0))
     gets();

}

free(sector);
printf("rc=%x\n", n1);
printf("Finished....\n");

}
