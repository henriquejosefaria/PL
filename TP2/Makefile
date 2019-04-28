# to use dot on mac do:
#	brew install xdot
#   brew install graphviz
#   echo 'export PATH="/usr/local/opt/icu4c/bin:$PATH"' >> ~/.bash_profile
#   echo 'export PATH="/usr/local/opt/icu4c/sbin:$PATH"' >> ~/.bash_profile
#   export LDFLAGS="-L/usr/local/opt/icu4c/lib"
#   export CPPFLAGS="-I/usr/local/opt/icu4c/include"
#   export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

all: a.out


a.out: preprocessamento processamento grafo
	rm grafo.dot

preprocessamento:
	gawk -f preprocessamento.awk < formacao.csv > next.csv 

processamento:
	gawk -f processamento.awk < next.csv > next2.txt

grafo:
	gawk -f dot.awk < next.csv
	dot -Tjpeg grafo.dot -o grafo.jpeg

.PHONY: clean

clean:
	rm next.csv
	rm grafo.dot
	rm grafo.jpeg
