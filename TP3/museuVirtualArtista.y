%{
	#define _GNU_SOURCE 
	#include <stdio.h>
	#include <string.h>
	#include <math.h>
	#include <unistd.h>
	void yyerror(char *s);
	char* prepareString(char* str);
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

grafos  : grafos ';' grafo			{asprintf(&$$,"%s\n%s",$3,$1);}
	    | grafo	       				{asprintf(&$$,"%s",$1);}
	    ;

grafo   : artista ligacoes			{asprintf(&$$,"%s\n%s",$1,$2);}
		| 							{$$="";}
	    ;

ligacoes: ligacoes musicaOuEvento	{asprintf(&$$,"%s\n%s",$2,$1);}
		| musicaOuEvento    		{asprintf(&$$,"%s",$1);}
		;

			      /* A PARTIR DAQUI DIVIDE-SE ENTRE HTML E DOT */

artista	: NOME IDADE CIDADE BIBLIOGRAFIA lista
								 	{myArtista = strdup($1);
									 char* f = malloc(sizeof(char)*strlen($1)+6);
									 sprintf(f,"%s.html",$1);
									 // aqui escreve para dot
									 asprintf(&$$,"\"%s\"[URL=\"%s\",shape=tripleoctagon,color=purple,style=filled];\n%s",$1,f,$5);
									 fd2=fopen(f,"w"); 
									 // a partir daqui para html
								     fprintf(fd2,"<html> \n\t<head> \n\t<h1>\n\t %s \n\t</h1> \n\t</head> \n\t<body> \n\t Idade: %d <br>\n\t Cidade: %s <br>\n\t Bibliografia: <blockquote style=\"height:300px; overflow: hidden; min-height: 300 px;\"> %s </blockquote> \n\t</body> \n</html>",$1,$2,$3,prepareString($4));
								    }			
									;

musicaOuEvento: NOME TIPO TEMPO LETRA
								 	{char* f = malloc(sizeof(char)*strlen($1)+6);
									 sprintf(f,"%s.html",$1);
									 // aqui escreve para dot
									 asprintf(&$$,"\"%s\"[shape=box,color=yellow,style=filled];\n\"%s\"[URL=\"%s\"];\n\"%s\" -> \"%s\"[label=\"Produziu\"];",$1,$1,f,myArtista,$1);
									 fd3=fopen(f,"w"); 
									 // a partir daqui para html
									 fprintf(fd3,"<html>\n\t <head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t Tipo: %s <br>\n\t Tempo: %.2f <br><br>\n\t Letra: <br> <p> %s </p>\n\t</body> \n</html>",$1,$2,$3,prepareString($4));
									}
			  | NOME TIPO DATA		{char* f = malloc(sizeof(char)*strlen($1)+6);
									 sprintf(f,"%s.html",$1);
									 // aqui escreve para dot
									 asprintf(&$$,"\"%s\"[color=red,style=filled];\n\"%s\"[URL=\"%s\"];\n\"%s\" -> \"%s\"[label=\"Participou\"];",$1,$1,f,myArtista,$1);
									 fd4=fopen(f,"w"); 
									 // a partir daqui para html
									 fprintf(fd4,"<html>\n\t <head> \n\t<h1> %s \n\t</h1> \n\t</head> \n\t<body> \n\t Tipo: %s <br>\n\t Data: %s \n\t</body> \n</html> ",$1,$2,$3);
									}
			  ;
			  
lista   : lista COLABOROU			{char* colab = malloc(sizeof(char)*strlen($2));
									 int i = 0,j = 0, index;
									 for(;$2[i]!='/';i++) colab[i] = $2[i];
									 index = i;
									 char* artista = malloc(sizeof(char)*strlen($2));
									 i++;
									 for(; $2[i]!='\0';j++,i++) artista[j] = $2[i];
									 artista[j] = colab[index] = '\0';
									 char* f = malloc(sizeof(char)*strlen($2)+6);
									 sprintf(f,"%s.html",colab);
									 if(fopen(f,"r")){
										 asprintf(&$$,"\"%s\" -> \"%s\"[URL=\"%s\", label=\"Colaborou\"];\n%s",artista,colab,f,$1);
									 } else{
									 	 asprintf(&$$,"\"%s\" -> \"%s\"[ label=\"Colaborou\"];\n%s",artista,colab,$1);
									 }
									}
		| lista APRENDEU		  	{char* apren = malloc(sizeof(char)*strlen($2));
									 int i = 0,j = 0, index;
									 for(;$2[i]!='/';i++) apren[i] = $2[i];
									 index = i;
									 char* artista = malloc(sizeof(char)*strlen($2));
									 i++;
									 for(; $2[i]!='\0';j++,i++) artista[j] = $2[i];
									 artista[j] = apren[index] = '\0';
									 char* f = malloc(sizeof(char)*strlen($2)+6);
									 sprintf(f,"%s.html",apren);
									 if(fopen(f,"r")){
										 asprintf(&$$,"\"%s\" -> \"%s\"[URL=\"%s\", label=\"Aprendeu\"];\n%s",artista,apren,f,$1);
									 } else{
									 	 asprintf(&$$,"\"%s\" -> \"%s\"[ label=\"Aprendeu\"];\n%s",artista,apren,$1);
									 }
									}
		| lista ENSINOU	 		 	{char* ensi = malloc(sizeof(char)*strlen($2));
									 int i = 0,j = 0, index;
									 for(;$2[i]!='/';i++) ensi[i] = $2[i];
									 index = i;
									 char* artista = malloc(sizeof(char)*strlen($2));
									 i++;
									 for(; $2[i]!='\0';j++,i++) artista[j] = $2[i];
									 artista[j] = ensi[index] = '\0';
									 char* f = malloc(sizeof(char)*strlen($2)+6);
									 sprintf(f,"%s.html",ensi);
									 if(fopen(f,"r")){
										 asprintf(&$$,"\"%s\" -> \"%s\"[URL=\"%s\", label=\"Ensinou\"];\n%s",artista,ensi,f,$1);
									 } else{
									 	 asprintf(&$$,"\"%s\" -> \"%s\"[ label=\"Ensinou\"];\n%s",artista,ensi,$1);
									 }
									}
		|					 	  	{$$="";}
		;

%%

 #include "lex.yy.c"
	
 void yyerror(char *s){fprintf(stderr,"ERRO:%s\nLine:%d\n",s,yylineno);}

 char* prepareString(char* str){
 int x,y;
 char* res = malloc(sizeof(char)*strlen(str)*2);
 for(x=0,y=0;str[x] != '\0';x++,y++){
 	if(str[x] == '\n'){
 		res[y] = '<';
 		res[y+1] = 'b';
 		res[y+2] ='r';
 		res[y+3] = '>';
 		y+=3;
 	} else res[y] = str[x];
 }
 res[y] = '\0';
 return res;
 }
 int main(int argc, char* argv[]) {
 	if(argc == 2)
 		yyin = fopen(argv[1],"r");
	yyparse();
	fclose(fd1);
	system("dot -Tsvg grafo.dot -o grafo.svg");
	return 0;
}