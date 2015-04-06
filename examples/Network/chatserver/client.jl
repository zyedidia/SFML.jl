using SFML

socket = TcpSocket()

connect(socket, "127.0.0.1", 53000, 10000)
println("Connected")

packet = Packet()
print("Name: ")
name = strip(readline(STDIN), '\n')
write_string(packet, name)

send_packet(socket, packet)
destroy(packet)

function get_messages()
	while true
		println("Ready to receive packet")
		packet = receive_packet(socket)
		msg = read_string(packet)
		println(msg)
		destroy(packet)
	end
end

function send_messages()
	while true
		println("Ready to receive input")
		msg = strip(readline(STDIN), '\n')
		packet = Packet()
		write_string(packet, name * ": " * msg)
		send_packet(socket, packet)

		destroy(packet)
	end
end

get_messages_task = Task(get_messages)
schedule(get_messages_task)
send_messages()
