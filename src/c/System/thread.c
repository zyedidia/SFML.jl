#include <SFML/Network.h>

void runFunction(void (*function)(void*), void* userData) {
	sfThread* t = sfThread_create(function, userData);
	sfThread_launch(t);
}
