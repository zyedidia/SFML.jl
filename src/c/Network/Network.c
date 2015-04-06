#include <stdio.h>
#include <SFML/Network.h>

sfTcpSocket* sjTcpListener_accept(sfTcpListener* listener, sfTcpSocket* connected) {
	sfTcpListener_accept(listener, &connected);
	return connected;
}

sfPacket* sjTcpSocket_receivePacket(sfTcpSocket* socket, sfPacket* packet) {
	sfTcpSocket_receivePacket(socket, packet);
	return packet;
}

char* sjPacket_readString(sfPacket* packet, char* str) {
	sfPacket_readString(packet, str);
	return str;
}
