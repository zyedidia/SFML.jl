#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <SFML/Network.h>

void sjThread_terminate(sfThread* thread) {
	sfThread_terminate(thread);
}

sfThread* runThread(void (*function)(void*), void* userData) {
	sfThread* t = sfThread_create(function, userData);
	sfThread_launch(t);

	/* sfThread* t2 = sfThread_create(&testfunction, NULL); */
	/* sfThread_launch(t2); */

	return t;
}
