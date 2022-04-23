#include <stdio.h>

int main(int argc, char **argv)
{
  int a = argc;
  char *s1 = argv[1];
  char *s2 = argv[2];
printf("argc=%d, argv[1]=%s, argv[2]=%s\n", a, s1, s2);
}
