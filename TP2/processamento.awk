BEGIN     {
	        FS=";"
        	RS="\n"
          }
		  {
            if(NF<=7){
               b++;
               print "\nCódigo: " $2 "\nTítulo: " $3 "\nDescrição: " $4 "\nNotas de aplicação: " $5 "\nNotas de exclusão: " $7 "\nDiplomas jurídico-administrativos REF: " $8 "\n\n"
               a[$10]++;
            } else if(NF<=15) {
               b++;
	           print "\nCódigo: " $2 "\nTítulo: " $3 "\nDescrição: " $4 "\nNotas de aplicação: " $5 "\nNotas de exclusão: " $7 "\nDiplomas jurídico-administrativos REF: " $8 "\nCódigo do processo relacionado: "  $15 "\n\n"
	           a[$10]++;
            }else {
               b++;
               print "\nCódigo: " $2 "\nTítulo: " $3 "\nDescrição: " $4 "\nNotas de aplicação: " $5 "\nNotas de exclusão: " $7 "\nDiplomas jurídico-administrativos REF: " $8 "\nCódigo do processo relacionado: "  $15 "\nNotas: " $27 "\n\n"
               a[$10]++;
            }
          }
END		  {
         print "\n\n Nº de ocorrencias registadas : " b;
         for(k in a){ 
            l = k;
            if(l == ""){ 
                 l="Desconhecido";
            }
            print "Processo : " l " -> " a[k]
         }
        }


