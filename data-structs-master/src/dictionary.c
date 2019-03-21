#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#include "../include/dictionary.h"


typedef struct TCD_DICTIONARY{
	char* word1;
	char* word2;
	char* word3;
	char* word4;
	char* word5;
	char* word6;
	char* word7;
} TCD_DICTIONARY;


TAD_DICTIONARY Dictionary(){
	TAD_DICTIONARY d = malloc(sizeof(TCD_DICTIONARY));
	d->word1 = NULL;
	d->word2 = NULL;
	d->word3 = NULL;
	d->word4 = NULL;
	d->word5 = NULL;
	d->word6 = NULL;
	d->word7 = NULL;
	return d;
}

void showTranslations(TAD_DICTIONARY d){
	printf("%s\n",d->word1 );
	printf("%s\n",d->word2 );
	printf("%s\n",d->word3 );
	printf("%s\n",d->word4 );
	printf("%s\n",d->word5 );
	printf("%s\n",d->word6 );
	printf("%s\n",d->word7 );
}

void addDic(TAD_DICTIONARY d, char* dados,int x){
	if(x == 1){setWord1(dados,d);}
	if(x == 2){setWord2(dados,d);}
	if(x == 3){setWord3(dados,d);}
	if(x == 4){setWord4(dados,d);}
	if(x == 5){setWord5(dados,d);}
	if(x == 6){setWord6(dados,d);}
	if(x == 7){setWord7(dados,d);}
}

void setWord1(char* word,TAD_DICTIONARY d){
     d->word1 = word;
}

void setWord2(char* word,TAD_DICTIONARY d){
	 d->word2 = word;
}

void setWord3(char* word,TAD_DICTIONARY d){
	 d->word3 = word;
}

void setWord4(char* word,TAD_DICTIONARY d){
	 d->word4 = word;
}

void setWord5(char* word,TAD_DICTIONARY d){
	 d->word5 = word;
}

void setWord6(char* word,TAD_DICTIONARY d){
	 d->word6 = word;
}

void setWord7(char* word,TAD_DICTIONARY d){
	 d->word7 = word;
}


