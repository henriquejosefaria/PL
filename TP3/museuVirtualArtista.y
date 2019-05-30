%{
	#define _GNU_SOURCE
	#include <stdio.h>
	#include <stdlib.h>
	int fd1 = fopen("grafo.svg","w");
	int fd2,fd3,fd4;
%}

%union{
	int n;
	float x;
	char* c;
}

%token NOME IDADE CIDADE TIPO TEMPO DATA COLABOROU APRENDEU ENSINOU PARTICIPOU PRODOZIU

%type <n> IDADE
%type <x> TEMPO
%type <c> NOME CIDADE TIPO DATA COLABOROU APRENDEU ENSINOU PARTICIPOU PRODOZIU

%%

prog	: grafos	   				{fprintf(fd1,"%s\n",$1);close(fd1);}
		;

grafos  : grafo grafos 				{asprintf(&$$,"%s\n%s",$1,$2);}
	    | grafo        				{asprintf(&$$,"%s\n",$1);}
	    ;

grafo   : artista ligacoes    		{asprintf(&$$,"%s\n%s",$1,$2);}
	    | artista			  		{asprintf(&$$,"%s\n",$1);}
	    ;

ligacoes: musica ligacoes	  		{asprintf(&$$,"%s\n%s",$1,$2);}
		| evento ligacoes	  		{asprintf(&$$,"%s\n%s",$1,$2);}
		| 					  		{$$="";}
		;

			      /* A PARTIR DAQUI DIVIDE-SE ENTRE HTML E DOT */

artista	: NOME IDADE CIDADE lista 	{asprintf(&$$,"%s ->{%s}\n",$1,$4); // imprime para o dot
									 fd2=fopen($1".html","w"); // a partir daqui para html
								     fprintf(fd2,"<html> \n\t<head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t %s \n\t %s \n\t %s \n\t</body> \n</html>",$1,$2,$3,$4);
								     close(fd2);
								    }			
		;

musica 	: NOME TIPO TEMPO 		  	{
									 asprintf(&$$,"%s\n",$1); // imprime para o dot nome
									 fd3=fopen($1".html","w"); // a partir daqui para html
									 fprintf(fd3,"<html>\n\t <head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t %s \n\t %s \n\t</body> \n</html> ",$1,$2,$3);
									 close(fd3);
									}
		;

evento	: NOME TIPO DATA		  	{
									 asprintf(&$$,"%s\n",$1); // imprime para o dot nome
									 fd4=fopen($1".html","w"); // a partir daqui para html
									 fprintf(fd4,"<html>\n\t <head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t %s \n\t %s \n\t</body> \n</html> ",$1,$2,$3);
									 close(fd4);
									}
		;
			  /* PROBLEMA: SE TIVERMOS UMA OU MAIS LIGAÇÕES E 1 VAZIO {A,B,} */
			  
lista   : COLABOROU NOME lista	  	{asprintf(&$$," %s[label="%s"],%s",$2,$1,$3);}
		| APRENDEU NOME lista	  	{asprintf(&$$," %s[label="%s"],%s",$2,$1,$3);}
		| ENSINOU NOME lista	  	{asprintf(&$$," %s[label="%s"],%s",$2,$1,$3);}
		| PARTICIPOU NOME lista	  	{asprintf(&$$," %s[label="%s"],%s",$2,$1,$3);}
		| PRODUZIU NOME lista	  	{asprintf(&$$," %s[label="%s"],%s",$2,$1,$3);}
		|					 	  	{$$="";}
		;

%%

#include "lex.yy.c"

int main() {
	yyparse();
	return 0;
}