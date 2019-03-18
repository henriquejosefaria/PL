#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#include <htable.h>

#define FREE                      0
#define USED                      1


typedef struct cell{
	long id;
	long status;
	long colisoes;
	void *dados;
} HTABLE_CELL;


typedef struct TCD_HTABLE{
	HTABLE_CELL* celulas;
	long ocupados;
	long dim;
} TCD_HTABLE;
	

static void resize(TAD_HTABLE htable);
static long hash(long id, long dim);


long getIdAtIndex(TAD_HTABLE htable, long index){
	#ifdef TESTA_ERRO_HTABLE
	if (htable == NULL || htable->celulas == NULL){
		perror("htable == NULL || htable->celulas == NULL: getIdAtIndex() on module HTABLE"); 
		exit(EXIT_FAILURE);
	}	
	#endif
	return htable->celulas[index].id;
}


void* getDados(TAD_HTABLE htable, long id){
	#ifdef TESTA_ERRO_HTABLE
	if (htable == NULL || htable->celulas == NULL){
		perror("htable == NULL || htable->celulas == NULL: getDados() on module HTABLE"); 
		exit(EXIT_FAILURE);
	}	
	#endif
	long index = indexOf(id, htable);
	return htable->celulas[index].dados;
}


void* getDadosAtIndex(TAD_HTABLE htable, long index){
	#ifdef TESTA_ERRO_HTABLE
	if (htable == NULL || htable->celulas == NULL){
		perror("htable == NULL || htable->celulas == NULL: getDadosAtIndex() on module HTABLE"); 
		exit(EXIT_FAILURE);
	}	
	#endif
	return htable->celulas[index].dados;
}


long getHtableSize(TAD_HTABLE htable){
	#ifdef TESTA_ERRO_HTABLE
	if (htable == NULL || htable->celulas == NULL){
		perror("htable == NULL || htable->celulas == NULL: getHtableSize() on module HTABLE"); 
		exit(EXIT_FAILURE);
	}	
	#endif
	return htable->dim;
}


TAD_HTABLE Htable(long dim){
	#ifdef TESTA_ERRO_HTABLE
	if (dim == 0){
		perror("dim == 0: Htable() on module HTABLE"); 
		exit(EXIT_FAILURE);
	}	
	#endif
	long i;
	TAD_HTABLE h = malloc(sizeof(TCD_HTABLE));
	h->celulas = malloc(sizeof(HTABLE_CELL) * dim);
	h->ocupados = 0;
	h->dim = dim;
	for (i = 0; i < dim; i++){
		h->celulas[i].status = FREE;
		h->celulas[i].colisoes = 0;
		h->celulas[i].dados = NULL;
	}
	return h;
}


void add(void* dados, long id, TAD_HTABLE htable){
	#ifdef TESTA_ERRO_HTABLE
	if (htable == NULL || htable->celulas == NULL || dados == NULL){
		perror("htable == NULL || htable->celulas == NULL || dados == NULL: add() on module HTABLE"); 
		exit(EXIT_FAILURE);
	}	
	#endif
	long i = 1; // variável que vai realizar o quadratic probing
	long dim = htable->dim;
	long p = hash(labs(id), dim); // posicao do user na tabela de hash
	long p_inicial = p;
	htable->ocupados++;
	HTABLE_CELL* h = htable->celulas;
	while(h[p].status == USED){		//	vai percorrer até encontrar um posição FREE;
		p = hash(labs(id) + i * i, dim);
		i++;
	}  
	h[p].id = id;
	h[p].status = USED;
	h[p_inicial].colisoes = i - 1;
	h[p].dados = dados;
    if (usedPercentage(htable) > 0.7) {
    	resize(htable);
    }
}


void free_htable(TAD_HTABLE htable){
	if (htable){ 	
	   	if (htable->celulas){
	   		free(htable->celulas);
	   		htable->celulas = NULL;
	   	}
		free(htable);
		htable = NULL;
	}
}


static long hash(long id, long dim){
	#ifdef TESTA_ERRO_HTABLE
	if (dim == 0){
		perror("dim == 0: hash() on module HTABLE"); 
		exit(EXIT_FAILURE);
	}	
	#endif
	return id % dim;
}


long indexOf(long id, TAD_HTABLE htable){
	#ifdef TESTA_ERRO_HTABLE
	if (htable == NULL || htable->celulas == NULL){
		perror("htable == NULL || htable->celulas == NULL: indexOf() on module HTABLE"); 
		exit(EXIT_FAILURE);
	}	
	#endif
 	long i = 1; // variável que vai realizar o quadratic probing
 	long dim = htable->dim;
	long p = hash( labs(id), dim); // posicao do elemento na tabela de hash
    HTABLE_CELL* h = htable->celulas;
    long colisoes = h[p].colisoes;
	while(h[p].id != id && h[p].status != FREE && colisoes > 0){

		p = hash(labs(id) + i * i, dim);
		colisoes--;
		i++;
	}
	if (h[p].id == id && h[p].status == USED) return p;
	else return -1;
}


static void resize(TAD_HTABLE htable){
	#ifdef TESTA_ERRO_HTABLE
	if (htable == NULL || htable->celulas == NULL){
		perror("htable == NULL || htable->celulas == NULL: resize() on module HTABLE"); 
		exit(EXIT_FAILURE);
	}	
	#endif
	long i, newDim = htable->dim * 3;   
    HTABLE_CELL* newCells = malloc(sizeof(HTABLE_CELL) * newDim); // nova array de células
    for (i = 0; i < newDim; i++){
		newCells[i].status = FREE;
		newCells[i].colisoes = 0;
		newCells[i].dados = NULL;
	}
    for(i = 0; i < htable->dim; i++)
    	if(htable->celulas[i].status == USED){
    		void* dados = htable->celulas[i].dados;
    		long id = htable->celulas[i].id;
    		long v = 1; // variável que vai realizar o quadratic probing
			long p = hash(labs(id), newDim); // posicao do user na tabela de hash
			long p_inicial = p;
			while(newCells[p].status == USED){		//	vai percorrer até encontrar um posição FREE;

				p = hash(labs(id) + v * v, newDim);
				i++;
			}    
			newCells[p].id = id;
			newCells[p].status = USED;
			newCells[p_inicial].colisoes = v - 1;
			newCells[p].dados = dados;
    	}	 
   	HTABLE_CELL* oldCells = htable->celulas;
    htable->dim = newDim;
    htable->celulas = newCells;
  	free(oldCells);
}


void set(void* dados, long index, TAD_HTABLE htable){
	#ifdef TESTA_ERRO_HTABLE
	if (htable == NULL || htable->celulas == NULL){
		perror("htable == NULL || htable->celulas == NULL: set() on module HTABLE"); 
		exit(EXIT_FAILURE);
	}	
	#endif
	HTABLE_CELL* h = htable->celulas;
	h[index].dados = dados;
}


float usedPercentage(TAD_HTABLE htable){
	#ifdef TESTA_ERRO_HTABLE
	if (htable == NULL){
		perror("htable == NULL: usedPercentage() on module HTABLE"); 
		exit(EXIT_FAILURE);
	}	
	#endif
    return (float) htable->ocupados / (float) htable->dim;
}