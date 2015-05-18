using SFML

server = TcpListener()
set_blocking(server, false)

listen(server, 53000)
println("Listening on port 53000")

client = SocketTCP()
while accept(server, client) != SOCKET_DONE
end

packet = Packet()
println(receive(client, packet))

println(read_string(packet))
println(read_string(packet))
