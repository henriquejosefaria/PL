CC=gcc
CFLAGS= -Wall -O2

all: tp1

lex.yy.c: tp1.fl
	flex tp1.fl

tp1: lex.yy.c htable.c 
	$(CC) lex.yy.c htable.c -o tp1 $(CFLAGS)

.PHONY: clean

clean_tp1:
	rm lex.yy.c
	rm tp1

clean_tpum:
	rm lex.yy.c
	rm tpum
	rm output.txt

install: 
	cp tp1 /usr/local/bin/

uninstall:
	rm -f /usr/local/bin/tp1

tpum: tpum.fl
	flex tpum.fl
	$(CC) lex.yy.c htable.c arrayList.c -I htable.h -I arrayList -o tpum $(CFLAGS)