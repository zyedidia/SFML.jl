#include <SFML/System.h>
#include <stdio.h>

void otherThread() {
	while (1) {
		printf("On other thread\n");
	}
}

int main() {
	sfThread* t = sfThread_create(&otherThread, NULL);
	sfThread_launch(t);

	while (1) {
		printf("On main thread\n");
	}
	return 0;
}
