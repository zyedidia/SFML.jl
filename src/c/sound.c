#include <stdio.h>
#include <SFML/Audio.h>

int main() {
	printf("Started");
	sfSoundBuffer* buffer = sfSoundBuffer_createFromFile("sound.wav");
	sfSound* sound = sfSound_create();
	sfSound_setBuffer(sound, buffer);

	sfSound_play(sound);
	printf("Played sound");

	return 0;
}
