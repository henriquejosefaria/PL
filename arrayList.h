#ifndef ARRAYLIST_H
#define ARRAYLIST_H

typedef struct TCD_ARRAY_LIST *TAD_ARRAY_LIST;

// Construtor
TAD_ARRAY_LIST ARRAY_LIST(int N);


// setters
void addElem(TAD_ARRAY_LIST list, void* elem);
void addElemAtIndex(TAD_ARRAY_LIST list, void* elem, int index);


// getters
void* getElem(TAD_ARRAY_LIST list, int index);
int getArraySize(TAD_ARRAY_LIST list);


// libertar memória
void free_ARRAY_LIST(TAD_ARRAY_LIST list);

#endif