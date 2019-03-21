#include <person.h>
#include <arrayList.h>
#include <htable.h>

#define INITIAL_ARRAYLIST_DIM		1


static void printPEOPLE(TAD_ARRAY_LIST people) {
	int size = getArraySize(people);
	for(int i=0; i<size; i++) {
		TAD_PERSON p = (TAD_PERSON) getElem(people, i);
		printPERSON(p);
	}
}


static void freePEOPLE(TAD_ARRAY_LIST people) {
	int size = getArraySize(people);
	for(int i=0; i<size; i++) {
		TAD_PERSON p = (TAD_PERSON) getElem(people, i);
		freePERSON(p);
	}
	free_ARRAY_LIST(people);
}


void ArrayListUsage() {

	TAD_PERSON musk = PERSON(0, "Elon Musk", 34);
	TAD_PERSON turing = PERSON(1, "Alon Turing", 41);

	// Create ArrayList named people
	TAD_ARRAY_LIST people = ARRAY_LIST(INITIAL_ARRAYLIST_DIM);
	
	// add elements to ArrayList
	addElem(people, musk);
	addElem(people, turing);

	// print all elements inside ArrayList
	printPEOPLE(people);

	// free all elements and ArrayList structure
	freePEOPLE(people);
}


int main() {
	ArrayListUsage();
	return 0;
}