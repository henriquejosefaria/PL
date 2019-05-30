%{
	#define _GNU_SOURCE 
	#include <stdio.h>
	#include <math.h>
	#include <unistd.h>
	void yyerror(char *s);
	int yylex();
	FILE* fd1 = fopen("grafo.svg","w");
	FILE* fd2,*fd3,*fd4;
%}
	// simbolos terminais
%token NOME IDADE CIDADE TIPO TEMPO DATA COLABOROU APRENDEU ENSINOU PARTICIPOU PRODUZIU

%union{
	int n;
	float x;
	char* c;
}

%type <n> IDADE
%type <x> TEMPO
%type <c> grafos grafo artista ligacoes lista musicaOuEvento NOME CIDADE TIPO DATA COLABOROU APRENDEU ENSINOU PARTICIPOU PRODUZIU

%%

prog	: grafos	   				{fprintf(fd1,"%s\n",$1);
									 //close(fd1);
									}
		;

grafos  : grafo grafos 				{asprintf(&$$,"%s\n%s",$1,$2);}
	    | grafo        				{asprintf(&$$,"%s\n",$1);}
	    ;

grafo   : artista ligacoes    		{asprintf(&$$,"%s\n%s",$1,$2);}
	    | artista			  		{asprintf(&$$,"%s\n",$1);}
	    ;

ligacoes: musicaOuEvento ligacoes	{asprintf(&$$,"%s\n%s",$1,$2);}
		|							{$$="";}
		;


			      /* A PARTIR DAQUI DIVIDE-SE ENTRE HTML E DOT */

artista	: NOME IDADE CIDADE lista 	{asprintf(&$$,"%s ->{%s}\n",$1,$4); //imprime para o dot
									 char* f;
									 sprintf( f, "%s%s",$1,".html");
									 fd2=fopen(f,"w"); // a partir daqui para html
								     fprintf(fd2,"<html> \n\t<head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t %d \n\t %s \n\t %s \n\t</body> \n</html>",$1,$2,$3,$4);
								     //close(fd2);
								    }			
									;

musicaOuEvento: NOME TIPO TEMPO 	{
									 asprintf(&$$,"%s\n",$1); // imprime para o dot nome
									 char* f;
									 sprintf( f, "%s%s",$1,".html");
									 fd3=fopen(f,"w"); // a partir daqui para html
									 fprintf(fd3,"<html>\n\t <head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t %s \n\t %f \n\t</body> \n</html>",$1,$2,$3);
									 //close(fd3);
									}
			  | NOME TIPO DATA		{
									 asprintf(&$$,"%s\n",$1); // imprime para o dot nome
									 char* f;
									 sprintf( f, "%s%s",$1,".html");
									 fd4=fopen(f,"w"); // a partir daqui para html
									 fprintf(fd4,"<html>\n\t <head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t %s \n\t %s \n\t</body> \n</html> ",$1,$2,$3);
									 //close(fd4);
									}
			  ;

			  /* PROBLEMA: SE TIVERMOS UMA OU MAIS LIGAÇÕES E 1 VAZIO {A,B,} */
			  
lista   : COLABOROU NOME lista	  	{asprintf(&$$," %s[label=\"%s\"],%s",$2,$1,$3);}
		| APRENDEU NOME lista	  	{asprintf(&$$," %s[label=\"%s\"],%s",$2,$1,$3);}
		| ENSINOU NOME lista	  	{asprintf(&$$," %s[label=\"%s\"],%s",$2,$1,$3);}
		| PARTICIPOU NOME lista	  	{asprintf(&$$," %s[label=\"%s\"],%s",$2,$1,$3);}
		| PRODUZIU NOME lista	  	{asprintf(&$$," %s[label=\"%s\"],%s",$2,$1,$3);}
		|					 	  	{$$="";}
		;

%%

#include "lex.yy.c"
	
	void yyerror(char *s){fprintf(stderr,"ERRO:%s\nLine:%d\n",s,yylineno);}

	int main() {
		yyparse();
		return 0;
	}