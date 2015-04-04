using SFML

server = TcpListener()

listen(server, 53000)
println("Listening on port 53000")

client = TcpSocket()

accept(server, client)
println("Client connected")
