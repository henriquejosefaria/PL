#ifndef DICTIONARY_H
#define DICTIONARY_H

typedef struct TCD_DICTIONARY* TAD_DICTIONARY;


TAD_DICTIONARY Dictionary();
void showTranslations();
void addDic(TAD_DICTIONARY d, char* dados,int x);
void setWord1(char* word,TAD_DICTIONARY d);
void setWord2(char* word,TAD_DICTIONARY d);
void setWord3(char* word,TAD_DICTIONARY d);
void setWord4(char* word,TAD_DICTIONARY d);
void setWord5(char* word,TAD_DICTIONARY d);
void setWord6(char* word,TAD_DICTIONARY d);
void setWord7(char* word,TAD_DICTIONARY d);

#endif