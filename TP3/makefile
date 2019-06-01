all: clean comp dot exec

comp: museuVirtualArtista.fl museuVirtualArtista.y
	flex -f -8 museuVirtualArtista.fl
	yacc -v museuVirtualArtista.y
	cc -o MvA y.tab.c  #ao incluir o outro faz compilação geral

dot: texto.txt
	./MvA < texto.txt
	dot -Tsvg grafo.dot -o grafo.svg

exec:
	google-chrome grafo.svg

clean:
	rm -f y.tab.*
	rm -f lex.yy.c
	rm -f MvA
	rm -f grafo.svg
	rm -f grafo.dot
	rm -f *.html
	rm -f y.output