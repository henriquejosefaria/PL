%{
	#define _GNU_SOURCE
	#include <stdio.h>
	#include <stdlib.h>
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

prog	: grafos	   				{fprintf(fileDesc,"%s\n",$1);}
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

artista	: NOME IDADE CIDADE lista 	{asprintf(&$$,"%s \n %s \n %s \n %s",$1,$2,$3,$4);}
		;

musica 	: NOME TIPO TEMPO 		  	{}
		;

evento	: NOME TIPO DATA		  	{}
		;

lista   : COLABOROU NOME lista	  	{}
		| APRENDEU NOME lista	  	{}
		| ENSINOU NOME lista	  	{}
		| PARTICIPOU NOME lista	  	{}
		| PRODUZIU NOME lista	  	{}
		|					 	  	{}
		;

%%

#include "lex.yy.c"

int main() {
	yyparse();
	return 0;
}