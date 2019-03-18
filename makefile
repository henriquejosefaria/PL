CC=gcc
CFLAGS= -Wall

all: tp1

lex.yy.c: tp1.fl
	flex tp1.fl

tp1: lex.yy.c htable.c 
	$(CC) lex.yy.c htable.c -o tp1 $(CFLAGS)

.PHONY: clean

clean:
	rm lex.yy.c
	rm tp1

install: 
	cp tp1 /usr/local/bin/

uninstall:
	rm -f /usr/local/bin/tp1