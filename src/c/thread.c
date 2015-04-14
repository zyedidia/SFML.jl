#include <SFML/System.h>
#include <stdio.h>

void thread1() {
	while (1) {
		printf("thread 1\n");
	}
}

void thread2() {
	while (1) {
		printf("thread 2\n");
	}
}

int main() {
	sfThread* t = sfThread_create(&thread1, NULL);
	sfThread_launch(t);
	sfThread* t2 = sfThread_create(&thread2, NULL);
	sfThread_launch(t2);

	int i = 0;

	while (1) {
		printf("On main thread\n");
	}
	return 0;
}
