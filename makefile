CC=gcc
CFLAGS= $(shell pkg-config --cflags glib-2.0)
LFLAGS= $(shell pkg-config --libs glib-2.0)

all: tp1 install

lex.yy.c: 1tp1.fl
	flex -8 -f 1tp1.fl

tp1: lex.yy.c
	$(CC) $(CFLAGS) lex.yy.c -o tp1 $(LFLAGS)  

.PHONY: clean

clean:
	rm -f lex.yy.c
	rm -f tp1
	rm -f output.txt

install: unistall tp1
	sudo cp tp1 /usr/local/bin

unistall:
	sudo rm -f /usr/local/bin/tp1