#include <stdio.h>
#include <SFML/Network.h>

int main() {
	void* server = sfTcpListener_create();
	sfTcpListener_listen(server, 53000);
	printf("Listening on port 53000\n");

	void* client = sfTcpSocket_create();
	sfTcpListener_accept(server, &client);
	printf("Client connected\n");

	void* packet = sfPacket_create();
	sfTcpSocket_receivePacket(client, packet);

	printf("Data: %d\n", sfPacket_readBool(packet));

	return 0;
}
