#include <stdio.h>
#include <SFML/Audio.h>

sfSoundBuffer* sjSoundBuffer_createFromFile(char* filename) {
	return sfSoundBuffer_createFromFile(filename);
}

void sjSound_setBuffer(sfSound* sound, sfSoundBuffer* buffer) {
	sfSound_setBuffer(sound, buffer);
}

void sjSound_play(sfSound* sound) {
	/* sfSoundBuffer* buffer = sfSoundBuffer_createFromFile("sound.wav"); */
	/* sfSound* sound = sfSound_create(); */
	/* sfSound_setBuffer(sound, buffer); */

	sfSound_play(sound);

	/* printf("Playing sound"); */
	/* sfSound_play(sound); */
}
