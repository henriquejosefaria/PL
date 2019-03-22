CC=gcc
CFLAGS= $(shell pkg-config --cflags glib-2.0)

LFLAGS= $(shell pkg-config --libs glib-2.0)

all: a.out

lex.yy.c: 1tp1.fl
	flex 1tp1.fl

a.out: lex.yy.c htable.c 
	$(CC) $(CFLAGS) lex.yy.c htable.c -o tp1 $(LFLAGS)  

.PHONY: clean

clean:
	rm -f lex.yy.c
	rm -f tp1