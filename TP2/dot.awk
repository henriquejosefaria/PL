BEGIN 	{
			FS=";"
			print "digraph {" > "grafo.dot"
			print " rankdir=LR;" > "grafo.dot"
		}
NR > 0	{
			if ($8!="")	{
				str = substr($8,2,length($8)-2)
				split(str,v,"#")
				for(a in v)
					if(v[a]!="")
						resultado[$2][v[a]]++
			}
		}
END 	{
			for(i in resultado)
				for(j in resultado[i])
					printf(" \"%s\" -> \"%s\";\n",i,j) > "grafo.dot"		
			print "}" > "grafo.dot"
		}