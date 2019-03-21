Generic Data Structures
=======================

Generic implementation of [data structures](https://en.wikipedia.org/wiki/Data_structure) in C. <br> 
For the moment we have implemented:
1. [Array List](https://en.wikipedia.org/wiki/Dynamic_array) </li>
2. [Hash Table](https://en.wikipedia.org/wiki/Hash_table) </li>

This API is [open source](https://github.com/RicardoPetronilho98/data-structs/blob/master/LICENSE) and made by [me](https://ricardopetronilho98.github.io/), [José Pereira](https://josepereira1.github.io/) and [Henrique Faria](https://github.com/henriquejosefaria).


## About ##

### How to compile & run: ###
1. make </li>
2. ./main </li>

### Project structure: ###
src/ (contains .c files) <br>
include/ (contains .h files) 

### Example of usage: ###
```c
void printPEOPLE(TAD_ARRAY_LIST people) {
	int size = getArraySize(people);
	for(int i=0; i<size; i++) {
		TAD_PERSON p = (TAD_PERSON) getElem(people, i);
		printPERSON(p);
	}
}


void freePEOPLE(TAD_ARRAY_LIST people) {
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
```
### READ ME (VERY IMPORTANT): ###
Because this implementation is generic we can not guess what data type is going to be stored in each data structure so ***it's user task to allocate and free memory created by him.*** The free() method for each data structure only frees the structure itself not the elements added by user. <br>
This is demonstrated in API usage above if you notice the user had to implement printPEOPLE() and freePEOPLE() because it's user specific code. <br>
The freePEOPLE() frees user created data one by one and after calls free() function from ArrayList structure. <br> 
<br>
To sum up you should (must) implement bellow interface for each data:
1. print(StructureName)() </li>
2. free(StructureName)() </li>

## FAQ ##

### What data type can each data structure store? ###
Any data type (int\* , float\*, char\*, strucutres implemented by user, etc.) can be stored. <br>
This is guaranteed because we use void* data type wich means any pointer can be stored.