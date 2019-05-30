all:
	flex -f museuVirtualArtista.fl
	yacc -v museuVirtualArtista.y
	cc -o MvA y.tab.c  #ao incluir o outro faz compilação geral

exec:
	./MvA <exemplo3.txt
	dot -Tsvg grafo.svg -o grafo.svg

clean:
	rm -f y.tab.c
	rm -f lex.yy.c
	rm -f MvA
	rm -f grafo.svg