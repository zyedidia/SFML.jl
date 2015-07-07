using SFML

function handle_client(client)
    while true
        packet = Packet()

        while receive(client, packet) != SOCKET_DONE
            sleep(0)
        end

        msg = read_string(packet)

        println("Received: $msg")

        out_packet = Packet()
        write(out_packet, msg)
        send(client, out_packet)
    end
end

server = TcpListener()
set_blocking(server, false)

if listen(server, 8080) != SOCKET_DONE
    println("Failed")
    exit(1)
end

println("Listening on port 8080")

while true
    client = SocketTCP()
    while accept(server, client) != SOCKET_DONE
        sleep(0)
    end
    println("Client connected from $(get_remoteaddress(client))")

    @async begin
        handle_client(client)
    end
end

