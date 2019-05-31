all:
	flex -f museuVirtualArtista.fl
	yacc -v museuVirtualArtista.y
	cc -o MvA y.tab.c  #ao incluir o outro faz compilação geral

exec:
	./MvA <exemplo3.txt
	dot -Tsvg grafo.dot -o grafo.svg

clean:
	rm -f y.tab.*
	rm -f lex.yy.c
	rm -f MvA
	rm -f grafo.svg
	rm -f grafo.dot
	rm -f *.html
	rm -f y.output