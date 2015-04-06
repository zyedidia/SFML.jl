using SFML

function receive_msg()
	while true
		println("Ready to receive packet\n")
		packet = receive_packet(client)
		msg = read_string(packet)
		println(msg)
		for i = 1:length(clients)
			send_packet(clients[i], packet)
		end
		destroy(packet)
	end
end

function receive_connections()
	while connections < max_connections
		println("Ready to receive client")
		client = accept(server)
		# println(client)
		if (client.ptr != Ptr{Void}(0))
			push!(clients, client)

			packet = receive_packet(client)
			name = read_string(packet)
			destroy(packet)
			println("$name connected")
		end
	end
end


server = TcpListener()

max_connections = 10
connections = 0

listen(server, 53000)
println("Listening on port 53000")

clients = TcpSocket[]

# t = Task(receive_connections)
# schedule(t)
receive_msg()
Thread(receive_connections)
