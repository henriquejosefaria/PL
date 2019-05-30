%{
	#define _GNU_SOURCE 
	#include <stdio.h>
	#include <string.h>
	#include <math.h>
	#include <unistd.h>
	void yyerror(char *s);
	int yylex();
	FILE* fd1;
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
prog	: grafos	   				{printf("1\n");
									 fd1 = fopen("grafo.dot","w");
									 fprintf(fd1,"digraph {\nrankdir=LR;\n%s\n}",$1);
									 printf("acabou\n\n");
									}
		;

grafos  : grafo grafos 				{printf("2\n");asprintf(&$$,"%s\n%s",$1,$2);}
	    | 	        				{$$="";printf("3\n");}
	    ;

grafo   : artista ligacoes			{printf("4\n");asprintf(&$$,"%s\n%s",$1,$2);}
	    ;

ligacoes: musicaOuEvento ligacoes	{printf("6\n");asprintf(&$$,"%s\n%s",$1,$2);}
		|							{printf("7\n");$$="";}
		;

			      /* A PARTIR DAQUI DIVIDE-SE ENTRE HTML E DOT */

artista	: NOME IDADE CIDADE lista 	{printf("8\n");
									 asprintf(&$$,"\"%s\" ->{%s};\n",$1,$4); //imprime para o dot
									 char* f = malloc(sizeof(char)*strlen($1)+6);
									 f = strdup($1);
									 strcat(f,".html");
									 fd2=fopen(f,"w"); // a partir daqui para html
								     fprintf(fd2,"<html> \n\t<head> \n\t<h1>\n\t %s \n\t</h1> \n\t</head> \n\t<body> \n\t Idade: %d \n\t Cidade: %s \n\t %s \n\t</body> \n</html>",$1,$2,$3,$4);
								    }			
									;

musicaOuEvento: NOME TIPO TEMPO 	{printf("9\n");
									 asprintf(&$$,"%s\n",$1); // imprime para o dot nome
									 char* f = malloc(sizeof(char)*strlen($1)+6);
									 f = strdup($1);
									 strcat(f,".html");
									 fd3=fopen(f,"w"); // a partir daqui para html
									 fprintf(fd3,"<html>\n\t <head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t %s \n\t %f \n\t</body> \n</html>",$1,$2,$3);
									}
			  | NOME TIPO DATA		{printf("10\n");
									 asprintf(&$$,"%s\n",$1); // imprime para o dot nome
									 char* f = malloc(sizeof(char)*strlen($1)+6);
									 f = strdup($1);
									 strcat(f,".html");
									 fd4=fopen(f,"w"); // a partir daqui para html
									 fprintf(fd4,"<html>\n\t <head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t %s \n\t %s \n\t</body> \n</html> ",$1,$2,$3);
									}
			  ;
			  
lista   : COLABOROU NOME lista	  	{printf("11\n");
									 asprintf(&$$," %s[label=\"%s\"],%s",$2,$1,$3);
									 }
		| APRENDEU NOME lista	  	{printf("12\n");
									 asprintf(&$$," %s[label=\"%s\"],%s",$2,$1,$3);
									}
		| ENSINOU NOME lista	  	{printf("13\n");
									 asprintf(&$$," %s[label=\"%s\"],%s",$2,$1,$3);
									}
		| PARTICIPOU NOME lista	  	{printf("14\n");
									 asprintf(&$$," %s[label=\"%s\"],%s",$2,$1,$3);
									}
		| PRODUZIU NOME lista	  	{printf("15\n");
									 asprintf(&$$," %s[label=\"%s\"],%s",$2,$1,$3);
									}
		|					 	  	{printf("sem relações\n");$$="\"\"";}
		;

%%

 #include "lex.yy.c"
	
 void yyerror(char *s){fprintf(stderr,"ERRO:%s\nLine:%d\n",s,yylineno);}

 int main() {
	yyparse();
	return 0;
}