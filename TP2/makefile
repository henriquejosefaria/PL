preprocessamento: preprocessamento.gawk
	gawk -f preprocessamento.gawk formacao.csv > output.csv

processamento: preprocessamento.gawk processamento.gawk	
	gawk -f preprocessamento.gawk formacao.csv > output.txt
	gawk -f processamento.gawk output.txt > output2.txt

clean: 
	rm -f output.*