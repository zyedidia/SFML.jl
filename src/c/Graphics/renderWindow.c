#include <stdlib.h>
#include <SFML/Graphics.h>

sfRenderWindow* new_sjRenderWindow(char* title, int width, int height) {
	sfVideoMode mode = {width, height};
	return sfRenderWindow_create(mode, title, sfResize | sfClose, NULL);
}
