#include <stdlib.h>
#include <SFML/Window/Event.h>

sfEvent* new_sjEvent() {
    sfEvent* pEvent;
    return malloc(sizeof* pEvent);
}

void sjEvent_destroy(sfEvent* pEvent) {
    free(pEvent);
}

int sjEvent_eventType(sfEvent* pEvent) {
    return pEvent->type;
}

sfSizeEvent sjEvent_eventSize(sfEvent* pEvent) {
    return pEvent->size;
}

sfKeyEvent sjEvent_eventKey(sfEvent* pEvent) {
    return pEvent->key;
}

sfTextEvent sjEvent_eventText(sfEvent* pEvent) {
    return pEvent->text;
}

sfMouseMoveEvent sjEvent_eventMouseMove(sfEvent* pEvent) {
    return pEvent->mouseMove;
}

sfMouseButtonEvent sjEvent_eventMouseButton(sfEvent* pEvent) {
    return pEvent->mouseButton;
}

sfMouseWheelEvent sjEvent_eventMouseWheel(sfEvent* pEvent) {
    return pEvent->mouseWheel;
}

sfJoystickMoveEvent sjEvent_eventJoystickMove(sfEvent* pEvent) {
    return pEvent->joystickMove;
}

sfJoystickButtonEvent sjEvent_eventJoystickButton(sfEvent* pEvent) {
    return pEvent->joystickButton;
}

sfJoystickConnectEvent sjEvent_eventJoystickConnect(sfEvent* pEvent) {
    return pEvent->joystickConnect;
}
