#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <SFML/Network.h>

void testfunction() {
	printf("In test function\n");
}

void (*function_pointer)(void*)=NULL;

void runFunction(void (*function)(void*), void* userData, int functionSize) {
	memcpy(&function_pointer, function, sizeof(function_pointer));
	printf("%lu\n", function_pointer);
	function_pointer(userData);

	/* jlFunctionType jlfunction = malloc(functionSize); */

	/* memcpy(jlfunction, &testFunction, functionSize); */
	/* printf("Copied function to location %lu\n", jlfunction); */
	/* printf("Size %lu\n", sizeof(jlfunction)); */
	/* function(userData); */
	/* jlfunction(userData); */

	/* sfThread* t = sfThread_create(function_pointer, userData); */
	/* sfThread_launch(t); */
}
