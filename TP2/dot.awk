#2,8,9 -> 1,6,7
# resultado[$1][$6]++;
# resultado[$1][$7]++;
BEGIN 	{
			FS=";"
			print "digraph {" > "grafo.dot"
			print " rankdir=LR;" > "grafo.dot"
		}
NR > 5	{
			if ($1!="")	{
				str = substr($6,2,length($6)-2);
				split(str,v,"#");
				for(a in v)
					if(v[a]!="")
						resultado[$1][v[a]]++;
			}
		}
END 	{
			for(i in resultado)
				for(j in resultado[i])
				    printf(" \"%s\" -> \"%s\";\n",i,j) > "grafo.dot"		
			print "}" > "grafo.dot"
		}