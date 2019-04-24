get_dot: docawk
	dot -Tjpeg grafo.dot -o grafo.jpeg

docawk: processamento dot.awk
	gawk -f dot.awk pos.txt > grafo.dot

processamento: prepocessamento processamento.gawk
	gawk -f processamento.gawk prepro.txt > pos.txt
	
prepocessamento: preprocessamento.gawk
	gawk -f preprocessamento.gawk formacao.csv > prepro.txt

clean: 
	rm -f prepro.csv
	rm -f pos.csv
	rm -f grafo.*
	rm -f *.txt