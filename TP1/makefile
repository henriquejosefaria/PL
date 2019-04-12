CC=gcc
CFLAGS= $(shell pkg-config --cflags glib-2.0)
LFLAGS= $(shell pkg-config --libs glib-2.0)

all: clean files tp1 last

.PHONY: last

last: 
	iconv -c -s -f utf8 -t utf8 dictionary.txt > dic.txt

files: createFiles.c
	gcc createFiles.c -o files
	./files
	rm files

lex.yy.c: 1tp1.fl
	flex -8 -f 1tp1.fl

tp1: lex.yy.c
	$(CC) $(CFLAGS) lex.yy.c -o tp1 $(LFLAGS)
	time ./tp1 ptwiki-20190220-pttit_id.txt ptwiki-latest-langlinks.sql
	rm tp1

alternativa: clean files lex.yy.c
	$(CC) $(CFLAGS) lex.yy.c -o tp1 $(LFLAGS)

.PHONY: clean

clean:
	rm -f lex.yy.c
	rm -f tp1
	rm -f output.txt
	rm -f *.html
	rm -f dic.txt
	rm -f dictionary.txt
