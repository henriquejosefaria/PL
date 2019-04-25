# to use dot on mac do:
#	brew install xdot
#   brew install graphviz
#   echo 'export PATH="/usr/local/opt/icu4c/bin:$PATH"' >> ~/.bash_profile
#   echo 'export PATH="/usr/local/opt/icu4c/sbin:$PATH"' >> ~/.bash_profile
#   export LDFLAGS="-L/usr/local/opt/icu4c/lib"
#   export CPPFLAGS="-I/usr/local/opt/icu4c/include"
#   export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

all: a.out


a.out: preprocessamento processamento grafico
	rm grafo.dot
	eog grafo.jpeg

preprocessamento:
	gawk -f preprocessamento.awk < formacao.csv > next.csv 

processamento:
	gawk -f processamento.awk < next.csv > next2.csv
	rm next.csv

grafico:
	gawk -f dot.awk < next2.csv > posprocessamento.csv
	dot -Tjpeg grafo.dot -o grafo.jpeg
	rm next2.csv

.PHONY: clean

clean:
	rm grafo.jpeg