using SFML

socket = TcpSocket()

connect(socket, "127.0.0.1", 53000, 10000)
println("Connected")

packet = Packet()
name = strip(readline(STDIN), '\n')
write_string(packet, name)

send_packet(socket, packet)
destroy(packet)

function get_input()
	while true
		msg = strip(readline(STDIN), '\n')
		packet = Packet()
		write_string(packet, name * ": " * msg)
		send_packet(socket, packet)

		destroy(packet)
	end
end

while true
	r = remotecall(1, get_input)

	fetch(r)

	packet = receive_packet(socket)
	msg = read_string(packet)
	println(msg)
end
