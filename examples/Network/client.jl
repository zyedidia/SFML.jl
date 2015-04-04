using SFML
socket = TcpSocket()

status = connect(socket, "127.0.0.1", 53000, 1000000 * 100)
println(status == SocketStatus.DONE ? "Connected" : "Not connected") 
