using SFML

server = TcpListener()

listen(server, 53000)
println("Listening on port 53000")

client = accept(server)
println("Client connected")

packet = receive_packet(client)

println(read_string(packet))
println(read_string(packet))
