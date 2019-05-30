all:
	flex -8 -f museuVirtualArtista.fl
	yacc museuVirtualArtista.y
	gcc -Wall y.tab.c -o MvA
	./MvA < exemplo3.txt

clean:
	rm -f y.tab.c
	rm -f lex.yy.c
	rm -f MvA
	rm -f grafo.svg