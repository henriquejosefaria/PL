#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "arrayList.h"


typedef struct TCD_ARRAY_LIST{
	void** array;
	int ocupados;
	int dim;
} TCD_ARRAY_LIST;	



TAD_ARRAY_LIST ARRAY_LIST(int N){
    TAD_ARRAY_LIST list = malloc(sizeof(TCD_ARRAY_LIST));
    list->dim = N;
    list->ocupados = 0;
    list->array = malloc(list->dim * sizeof(void *));
    return list;
}


static void** array_copy(void** old_array, int old_dim, long new_dim){
	#ifdef TESTA_ERRO_ARRAY_LIST
    if (old_array == NULL){
        perror("old_array == NULL: array_copy() on module ARRAY_LIST");
        exit(EXIT_FAILURE);
    }
    #endif
	void** new_array = malloc(new_dim * sizeof(void*));	
	memcpy(new_array, old_array, old_dim * sizeof(void*));
	free(old_array);
	return new_array;
}


static void aumentaCapacidade(TAD_ARRAY_LIST list, int capacidade){ 
	#ifdef TESTA_ERRO_ARRAY_LIST
    if (list == NULL || capacidade <= 0){
        perror("list == NULL || capacidade <= 0: aumentaCapacidade() on module ARRAY_LIST");
        exit(EXIT_FAILURE);
    }
    #endif
	if ( capacidade > list->dim ){
		int nova_dim = list->dim * 2;
		list->array = array_copy(list->array, list->dim, nova_dim);
		list->dim = nova_dim;
	}
}


void addElemAtIndex(TAD_ARRAY_LIST list, void* elem, int index){
	#ifdef TESTA_ERRO_ARRAY_LIST
    if (index >= list->dim){
        perror("index >= list->dim: addElemAtIndex() on module ARRAY_LIST");
        exit(EXIT_FAILURE);
    }
    #endif
	list->array[index] = elem;
}


void addElem(TAD_ARRAY_LIST list, void* elem){
	#ifdef TESTA_ERRO_ARRAY_LIST
    if (list == NULL || elem == NULL){
        perror("list == NULL || elem == NULL: addElem() on module ARRAY_LIST");
        exit(EXIT_FAILURE);
    }
    #endif
	aumentaCapacidade(list, list->ocupados + 1);
	list->array[list->ocupados++] = elem;
}


void* getElem(TAD_ARRAY_LIST list, int index){
	#ifdef TESTA_ERRO_ARRAY_LIST
    if (index < 0 || list == NULL || index > list->ocupados){
        perror("lindex < 0 || list == NULL || index > list->ocupados: getElem() on module ARRAY_LIST");
        exit(EXIT_FAILURE);
    }
    #endif
	return list->array[index];
}


int getArraySize(TAD_ARRAY_LIST list){
	#ifdef TESTA_ERRO_ARRAY_LIST
    if (list == NULL){
        perror("list == NULL: getArraySize() on module ARRAY_LIST");
        exit(EXIT_FAILURE);
    }
    #endif
	return list->ocupados;
}


void free_ARRAY_LIST(TAD_ARRAY_LIST list){
	if (list){
		if (list->array){
			free(list->array);
			list->array = NULL;
		}
		free(list);
		list = NULL;
	}
}