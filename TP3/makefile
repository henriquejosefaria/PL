all: clean MvA install exec

mac: all execMac

linux:  all execLinux

execMac:
	open -a "Google Chrome" grafo.svg

execLinux:
	google-chrome grafo.svg


MvA: museuVirtualArtista.fl museuVirtualArtista.y
	flex -f -8 museuVirtualArtista.fl
	yacc -v museuVirtualArtista.y
	cc -o MvA y.tab.c  #ao incluir o outro faz compilação geral

exec: texto.txt
	MvA texto.txt

install: MvA
	cp MvA /usr/local/bin/

clean:
	rm -f y.tab.*
	rm -f lex.yy.c
	rm -f MvA
	rm -f grafo.svg
	rm -f grafo.dot
	rm -f *.html
	rm -f y.output
	sudo rm -f /usr/local/bin/MvA