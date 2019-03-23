CC=gcc
CFLAGS= $(shell pkg-config --cflags glib-2.0)

LFLAGS= $(shell pkg-config --libs glib-2.0)

all: clean

lex.yy.c: 1tp1.fl
	flex -8 1tp1.fl

tp1: lex.yy.c
	$(CC) $(CFLAGS) lex.yy.c -o tp1 $(LFLAGS)  

.PHONY: clean

clean:
	rm -f lex.yy.c
	rm -f tp1

install: tp1
	sudo cp tp1 /usr/local/bin

unistall:
	rm -f /usr/local/bin/tp1