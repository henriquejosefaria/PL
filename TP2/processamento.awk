BEGIN     {
	        FS=";"
        	RS="\n"
          }
		  {
            if(NF<=7){
               b++;
               print "\n" $2 ";" $3 ";" $4 ";" $5 ";" $7 ";" $8
               a[$10]++;
            } else if(NF<=15) {
               b++;
	           print "\n" $2 ";" $3 ";" $4 ";" $5 ";" $7 ";" $8 ";"  $15 
	           a[$10]++;
            }else if(NF <= 21)  {
               b++;
	           print "\n" $2 ";" $3 ";" $4 ";" $5 ";" $7 ";" $8 ";"  $15 ";\n" $21
	           a[$10]++;
            }else {
               b++;
               print "\n" $2 ";" $3 ";" $4 ";" $5 ";" $7 ";" $8 ";"  $15 ";" $21 ";\n" $27
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
