#include <stdlib.h>
#include <SFML/Window/Event.h>

sfEvent* new_sjEvent() {
	sfEvent* pEvent;
	return malloc(sizeof* pEvent);
}

int sjEvent_eventType(sfEvent* pEvent) {
	if (pEvent->type == sfEvtClosed) {
		return 1;
	}

	return 0;
}
