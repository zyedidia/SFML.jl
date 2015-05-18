using SFML

socket = SocketTCP()

connect(socket, "127.0.0.1", 53000, 10000)
println("Connected")

packet = Packet()
write(packet, "First String")
write(packet, "Second String")

send(socket, packet)
