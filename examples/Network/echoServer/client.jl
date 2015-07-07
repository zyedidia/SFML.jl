using SFML

const ipaddress = "127.0.0.1"
const port = 8080

socket = SocketTCP()

if connect(socket, ipaddress, port, 0) != SOCKET_DONE
    println("Connection to $ipaddress on port $port failed!")
    exit(1)
end

println("Connected")

packet = Packet()

while true
    packet = Packet()

    print("Message: ")
    msg = strip(readline(STDIN), '\n')

    write(packet, msg)
    send(socket, packet)

    in_packet = Packet()
    receive(socket, in_packet)
    println("Received: ", read_string(in_packet))
end
