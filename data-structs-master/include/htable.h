#ifndef HTABLE_H
#define HTABLE_H


typedef struct TCD_HTABLE* TAD_HTABLE;

/* Construtor */
TAD_HTABLE Htable(long dim); 


/* Getters */
long indexOf(long id, TAD_HTABLE htable);  
float usedPercentage(TAD_HTABLE htable); 
void getDados(TAD_HTABLE htable, long id); 
void* getDadosAtIndex(TAD_HTABLE htable, long index);
long getHtableSize(TAD_HTABLE htable);
long getIdAtIndex(TAD_HTABLE htable, long index);


/* Setters */
void add(void* dados, long id, TAD_HTABLE htable,int x); 
void set(void* dados, long index, TAD_HTABLE htable); 


/* free */
void free_htable(TAD_HTABLE htable);

#endif