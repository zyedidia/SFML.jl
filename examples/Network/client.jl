using SFML
socket = TcpSocket()

status = connect(socket, "127.0.0.1", 53000, 1000000 * 100)
println(status) 

packet = Packet()
write_bool(packet, true)
println(read_bool(packet))
send_packet(socket, packet)
