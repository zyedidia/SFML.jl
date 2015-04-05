using SFML

socket = TcpSocket()

connect(socket, "127.0.0.1", 53000, 10000)
println("Connected")

packet = Packet()
write_string(packet, "First String")
write_string(packet, "Second String")

send_packet(socket, packet)
