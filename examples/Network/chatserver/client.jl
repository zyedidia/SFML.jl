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
	msg = strip(readline(STDIN), '\n')
	packet = Packet()
	write_string(packet, name * ": " * msg)
	send_packet(socket, packet)

	destroy(packet)
end

input_task = @async begin
	while true
		get_intput()
	end
end

output_task = @async begin
	while true
		packet = receive_packet(socket)
		msg = read_string(packet)
		println(msg)
	end
end

consume(input_task)
consume(output_task)
