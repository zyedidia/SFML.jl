#include <stdlib.h>
#include <SFML/Window/Event.h>

sfEvent* new_sjEvent() {
	sfEvent* pEvent;
	return malloc(sizeof* pEvent);
}

int sjEvent_eventType(sfEvent* pEvent) {
	return pEvent->type;
}
