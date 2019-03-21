#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <person.h>

typedef struct TCD_PERSON {
	int id; // temos de garantir que é único
	char* name;
	int age; 
} TCD_PERSON; // P_PERSON é um apontador para a estrutura PERSON


TAD_PERSON PERSON(int id, char* name, int age) {
	TAD_PERSON p = (TAD_PERSON) malloc(sizeof(TCD_PERSON));
	setId(p, id);
	p->name = NULL;
	setName(p, name);
	setAge(p, age);
	return p;
}


int getId(TAD_PERSON p) {
	return p->id;
}


// garante o encapsulamento (retorna uma cópia, em vez do apontador dentro da estrutura)
char* getName(TAD_PERSON p) {
	char* res = (char*) malloc(sizeof(char) * (strlen(p->name)+1));
	strcpy(res, p->name);
	return res;
}


int getAge(TAD_PERSON p) {
	return p->age;
}


void setId(TAD_PERSON p, int id) {
	p->id = id;
}


// garante o encapsulamento (atribui uma cópia, em vez do apontador de fora da estrutura)
void setName(TAD_PERSON p, char* name) {
	if (p->name != NULL) free(p->name);
	p->name = (char*) malloc(sizeof(char) * (strlen(name)+1));
	strcpy(p->name, name);
}


void setAge(TAD_PERSON p, int age) {
	p->age = age;
}
 

void freePERSON(TAD_PERSON p) {
	if (p != NULL) {
		if (p->name != NULL) { 
			free(p->name);
			p->name = NULL;
		}
		free(p);
		p = NULL;
	}
}


void printPERSON(TAD_PERSON p) {
	printf("TAD_PERSON{id=%d, name=%s, age=%d}\n", p->id, p->name, p->age);
}
