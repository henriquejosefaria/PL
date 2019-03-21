IDIR=include/
CC=gcc
CFLAGS=-Wall -I $(IDIR)
CFILES=$(wildcard src/*.c)

get_main:
	$(CC) $(CFLAGS) $(CFILES) -o main

install: get_main
	cp main /usr/local/bin/

uninstall: clean

clean:
	rm -f main
	rm -f /usr/local/bin/main
