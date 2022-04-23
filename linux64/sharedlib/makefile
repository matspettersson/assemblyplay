all: hello

hello: hello.o  libshared.so
	#gcc hello.o sharedlib.o -o hello
	gcc -o hello hello.o -L. -lshared -Wl,-rpath,.

hello.o : hello.c makefile
	gcc -c -o hello.o hello.c

libshared.o : libshared.asm makefile
	nasm -felf64 -o libshared.o libshared.asm

libshared.so : libshared.o
	gcc -shared -fPIC -o libshared.so libshared.o

clean:
	rm hello.o libshared.o libshared.so hello
