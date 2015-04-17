using SFML

server = TcpListener()

listen(server, 53000)
println("Listening on port 53000")

client = TcpSocket()
println(accept(server, client))

packet = Packet()
receive_packet(client, packet)

println(read_string(packet))
println(read_string(packet))
