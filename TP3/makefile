all: comp exec

comp: museuVirtualArtista.fl museuVirtualArtista.y
	flex -f museuVirtualArtista.fl
	yacc -v museuVirtualArtista.y
	cc -o MvA y.tab.c  #ao incluir o outro faz compilação geral

exec: exemplo3.txt
	./MvA < exemplo3.txt
	dot -Tsvg grafo.svg -o grafo.svg

teste_flex: TestemuseuVirtualArtista.fl exemplo3.txt
	flex -f TestemuseuVirtualArtista.fl
	cc -o teste lex.yy.c
	./teste exemplo3.txt

clean:
	rm -f y.tab.c
	rm -f y.tab.h
	rm -f lex.yy.c
	rm -f MvA
	rm -f grafo.svg
	rm -f teste
	rm -f y.output
	rm -f *.html