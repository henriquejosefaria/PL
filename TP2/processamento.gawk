BEGIN     {
	          FS=";"
            RS="\n"
          }
		      {
            if(NF<=7)
            {
               b++;
               print "\n\nCodigo:" $2 "\nTitulo:" $3 "\nDescricao:" $4 "\nNotas:" $5 ";\n" $7
               a[$10]++;
            } 
            else if(NF<=15) 
            {
               b++;
	             print "\n\nCodigo -> " $2 "\nTitulo -> " $3 "\nDescricao -> " $4 "\nNotas -> " $5 "\n" $7 ";\n"  $15
	             a[$10]++;
            }
            else if(NF <= 21)  
            {
               b++;
	             print "\n\nCodigo -> " $2 "\nTitulo -> " $3 "\nDescricao -> " $4 "\nNotas -> " $5 ";\n" $7 ";\n"  $15 ";\n" $21
	            a[$10]++;
            }
            else 
            {
               b++;
               print "\n\nCodigo -> " $2 "\nTitulo -> " $3 "\nDescricao -> " $4 "\nNotas -> " $5 ";\n" $7 ";\n"  $15 ";\n" $21 ";\n" $27
               a[$10]++;
            }
          }
END		  {
          print "\n\n Nº de ocorrencias registadas : " b; for(k in a) print "Processo : " k " -> " a[k]
        }
