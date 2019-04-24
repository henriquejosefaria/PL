preprocessamento: preprocessamento.gawk
	gawk -f preprocessamento.gawk formacao.csv > output.csv

processamento: preprocessamento.gawk processamento.gawk	
	gawk -f preprocessamento.gawk < formacao.csv > prepro.csv
	gawk -f processamento.gawk < prepro.csv > pos.csv
	gawk -f dot.awk < pos.csv > grafo.dot
	dot -Tjpeg grafo.dot -o grafo.jpeg

clean: 
	rm -f output.*