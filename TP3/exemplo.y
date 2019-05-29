

%%

ficheiro: artistas
		;

artistas: artista artistas
		|
		;

artista: NOME IDADE CIDADE colaboradores obras eventos		{}
	   ;

colaboradores: colaborador colaboradores					{asprintf(&$$,"%s\n%s",$1,$2);}
			 |												{$$=""}
			 ;

colaborador: COLAB 											{asprintf(&$$,"NOTAÇÃO DOT",$1)}

obras: obra obras
	 |
	 ;

obra: CANCAO TIPO TEMPO										{asprintf(&$$,"NOTAÇÃO DOT",$1,$2,$3)}

eventos: evento eventos										{asprintf(&$$,"%s\n%s",$1,$2);}
	   |
	   ;

evento: EVENTO TYPE DATA									{asprintf(&$$,"NOTAÇÃO DOT",$1,$2,$3)}
	  ;
%%

#include "lex.yy.c"

int main() {
	yyparse();
	return 0;
}