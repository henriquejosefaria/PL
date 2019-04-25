BEGIN			{	
					FS=";"
					RS="(;{7,})\r\n"
				}
				{
					gsub(/"(;{27})"/,"") 
				}							
NR>1			{
					gsub(/\n/,"") 
					gsub(/\r/,"")
					if ($0=="") 
						sub($0,"")
				 	else 
				 	{
				 			if ($1=="") 
				 				sub($1,"NIL")
				 			print
				 	} 		
				}
END				{}
