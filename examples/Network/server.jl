using SFML

server = TcpListener()

println(listen(server, 53000))
println("Listening on port 53000")

client = TcpSocket()

accept(server, client)
println("Client connected")

packet = Packet()
receive_packet(client, packet)

println(get_data_size(packet))
