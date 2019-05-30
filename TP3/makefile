all:
	flex -f museuVirtualArtista.fl
	yacc -v museuVirtualArtista.y
	cc -o MvA y.tab.c  #ao incluir o outro faz compilação geral

exec:
	./MvA < exemplo3.txt
	dot -Tsvg grafo.svg -o grafo.svg

teste_flex:
	flex -f TestemuseuVirtualArtista.fl
	cc -o teste lex.yy.c
	./teste exemplo3.txt

clean:
	rm -f y.tab.c
	rm -f lex.yy.c
	rm -f MvA
	rm -f grafo.svg
	rm -f teste
	rm -f y.output