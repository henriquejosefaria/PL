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
	char* myArtista;
%}
	// simbolos terminais
%token NOME IDADE CIDADE TIPO TEMPO DATA COLABOROU APRENDEU ENSINOU PARTICIPOU PRODUZIU BIBLIOGRAFIA LETRA

%union{
	int n;
	float x;
	char* c;
}

%type <n> IDADE
%type <x> TEMPO
%type <c> grafos grafo artista ligacoes lista musicaOuEvento NOME CIDADE TIPO DATA COLABOROU APRENDEU ENSINOU PARTICIPOU PRODUZIU BIBLIOGRAFIA LETRA

%%
prog	: grafos	   				{fd1 = fopen("grafo.dot","w");
									 fprintf(fd1,"digraph {\nrankdir=LR;\n%s\n}",$1);
									}
		;

grafos  : grafo ';' grafos			{asprintf(&$$,"%s\n%s",$1,$3);}
	    | 		       				{$$="";}
	    ;

grafo   : artista ligacoes			{asprintf(&$$,"%s\n%s",$1,$2);}
		|							{$$="";}
	    ;

ligacoes: musicaOuEvento ligacoes	{asprintf(&$$,"%s\n%s",$1,$2);}
		|							{$$="";}
		;

			      /* A PARTIR DAQUI DIVIDE-SE ENTRE HTML E DOT */

artista	: NOME IDADE CIDADE BIBLIOGRAFIA lista
								 	{myArtista = strdup($1);
									 char* f = malloc(sizeof(char)*strlen($1)+6);
									 sprintf(f,"%s.html",$1);
									 asprintf(&$$,"\"%s\"[URL=\"%s\"];\n%s",$1,f,$5);
									 fd2=fopen(f,"w"); // a partir daqui para html
								     fprintf(fd2,"<html> \n\t<head> \n\t<h1>\n\t %s \n\t</h1> \n\t</head> \n\t<body> \n\t Idade: %d <br>\n\t Cidade: %s <br>\n\t Bibliografia: %s\n\t</body> \n</html>",$1,$2,$3,$4);
								    }			
									;

musicaOuEvento: NOME TIPO TEMPO LETRA
								 	{char* f = malloc(sizeof(char)*strlen($1)+6);
									 sprintf(f,"%s.html",$1);
									 asprintf(&$$,"\"%s\"[URL=\"%s\"];\n\"%s\" -> \"%s\"[label=\"Produziu\"];",$1,f,myArtista,$1);
									 f = malloc(sizeof(char)*strlen($1)+6);
									 sprintf(f,"%s.html",$1);
									 fd3=fopen(f,"w"); // a partir daqui para html
									 fprintf(fd3,"<html>\n\t <head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t Tipo: %s <br>\n\t Tempo: %.2f <br><br>\n\t Letra: <br> %s\n\t</body> \n</html>",$1,$2,$3,$4);
									}
			  | NOME TIPO DATA		{char* f = malloc(sizeof(char)*strlen($1)+6);
									 sprintf(f,"%s.html",$1);
									 asprintf(&$$,"\"%s\"[URL=\"%s\"];\n\"%s\" -> \"%s\"[label=\"Participou\"];",$1,f,myArtista,$1);
									 f = malloc(sizeof(char)*strlen($1)+6);
									 sprintf(f,"%s.html",$1);
									 fd4=fopen(f,"w"); // a partir daqui para html
									 fprintf(fd4,"<html>\n\t <head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t Tipo: %s <br>\n\t Data: %s \n\t</body> \n</html> ",$1,$2,$3);
									}
			  ;
			  
lista   : COLABOROU lista			{char* colab = malloc(sizeof(char)*strlen($1));
									 int i = 0,j = 0, index;
									 for(;$1[i]!='/';i++) colab[i] = $1[i];
									 index = i;
									 char* artista = malloc(sizeof(char)*strlen($1));
									 i++;
									 for(; $1[i]!='\0';j++,i++) artista[j] = $1[i];
									 artista[j] = colab[index] = '\0';
									 char* f = malloc(sizeof(char)*strlen($1)+6);
									 sprintf(f,"%s.html",colab);
									 if(fopen(f,"r")){
										 asprintf(&$$,"\"%s\" -> \"%s\"[URL=\"%s\", label=\"Colaborou\"];\n%s",artista,colab,f,$2);
									 } else{
									 	 asprintf(&$$,"\"%s\" -> \"%s\"[ label=\"Colaborou\"];\n%s",artista,colab,$2);
									 }
									 }
		| APRENDEU lista		  	{char* apren = malloc(sizeof(char)*strlen($1));
									 int i = 0,j = 0, index;
									 for(;$1[i]!='/';i++) apren[i] = $1[i];
									 index = i;
									 char* artista = malloc(sizeof(char)*strlen($1));
									 i++;
									 for(; $1[i]!='\0';j++,i++) artista[j] = $1[i];
									 artista[j] = apren[index] = '\0';
									 char* f = malloc(sizeof(char)*strlen($1)+6);
									 sprintf(f,"%s.html",apren);
									 if(fopen(f,"r")){
										 asprintf(&$$,"\"%s\" -> \"%s\"[URL=\"%s\", label=\"Aprendeu\"];\n%s",artista,apren,f,$2);
									 } else{
									 	 asprintf(&$$,"\"%s\" -> \"%s\"[ label=\"Aprendeu\"];\n%s",artista,apren,$2);
									 }
									}
		| ENSINOU lista	 		 	{char* ensi = malloc(sizeof(char)*strlen($1));
									 int i = 0,j = 0, index;
									 for(;$1[i]!='/';i++) ensi[i] = $1[i];
									 index = i;
									 char* artista = malloc(sizeof(char)*strlen($1));
									 i++;
									 for(; $1[i]!='\0';j++,i++) artista[j] = $1[i];
									 artista[j] = ensi[index] = '\0';
									 char* f = malloc(sizeof(char)*strlen($1)+6);
									 sprintf(f,"%s.html",ensi);
									 if(fopen(f,"r")){
										 asprintf(&$$,"\"%s\" -> \"%s\"[URL=\"%s\", label=\"Ensinou\"];\n%s",artista,ensi,f,$2);
									 } else{
									 	 asprintf(&$$,"\"%s\" -> \"%s\"[ label=\"Ensinou\"];\n%s",artista,ensi,$2);
									 }
									}
		|					 	  	{$$="";}
		;

%%

 #include "lex.yy.c"
	
 void yyerror(char *s){fprintf(stderr,"ERRO:%s\nLine:%d\n",s,yylineno);}

 int main() {
	yyparse();
	return 0;
}