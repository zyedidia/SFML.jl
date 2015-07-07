#include <stdlib.h>
#include <SFML/Network.h>

typedef struct NetworkStruct {
    int status;
    void* ptr;
} NetworkStruct;

NetworkStruct sjTcpListener_accept(sfTcpListener* listener, sfTcpSocket* connected) {
    NetworkStruct* s = malloc(sizeof *s);
    s->status = sfTcpListener_accept(listener, &connected);
    s->ptr = connected;
    return *s;
}

NetworkStruct sjTcpSocket_receivePacket(sfTcpSocket* socket, sfPacket* packet) {
    NetworkStruct* s = malloc(sizeof *s);
    s->status = sfTcpSocket_receivePacket(socket, packet);
    s->ptr = packet;
    return *s;
}

char* sjPacket_readString(sfPacket* packet, char* str) {
    sfPacket_readString(packet, str);
    return str;
}
