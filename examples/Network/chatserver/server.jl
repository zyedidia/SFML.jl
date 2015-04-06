using SFML

function receive_msg(client)
	while true
		packet = receive_packet(client)
		msg = read_string(packet)
		println(msg)
		for i = 1:length(clients)
			send_packet(clients[i], packet)
		end
		destroy(packet)
	end
end

server = TcpListener()

max_connections = 10
connections = 0

listen(server, 53000)
println("Listening on port 53000")

clients = TcpSocket[]


while connections < max_connections
	println("Ready to receive client")
	client = accept(server)
	push!(clients, client)

	receive_msg_task = @async begin
		while true
			receive_msg(client)
		end
	end

	packet = receive_packet(client)
	name = read_string(packet)
	destroy(packet)
	println("$name connected")

	consume(receive_msg_task)
end

