#ifndef PERSON_H
#define PERSON_H

typedef struct TCD_PERSON* TAD_PERSON;

// CONSTRUTOR
TAD_PERSON PERSON(int id, char* name, int age);

// GETTERS
int getId(TAD_PERSON p);
char* getName(TAD_PERSON p);
int getAge(TAD_PERSON p);

// SETTERS
void setId(TAD_PERSON p, int id);
void setName(TAD_PERSON p, char* name);
void setAge(TAD_PERSON p, int age);

// FREE
void freePERSON(TAD_PERSON p);

// toString()
void printPERSON(TAD_PERSON p);

#endif