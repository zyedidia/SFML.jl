type TcpSocket
	ptr::Ptr{Void}
end

function TcpSocket()
	return TcpSocket(ccall(dlsym(libcsfml_network, :sfTcpSocket_create), Ptr{Void}, ()))
end

function destroy(socket::TcpSocket)
	ccall(dlsym(libcsfml_network, :sfTcpSocket_destroy), Void, (Ptr{Void},), socket.ptr)
	socket = nothing
end

function set_blocking(socket::TcpSocket, blocking::Bool)
	ccall(dlsym(libcsfml_network, :sfTcpSocket_isBlocking), Void, (Ptr{Void}, Int32,), socket.ptr, blocking)
end

function is_blocking(socket::TcpSocket)
	return ccall(dlsym(libcsfml_network, :sfTcpSocket_getBlocking), Int32, (Ptr{Void},), socket.ptr) == 1
end

function get_localport(socket::TcpSocket)
	return ccall(dlsym(libcsfml_network, :sfTcpSocket_getLocalPort), Uint16, (Ptr{Void},), socket.ptr)
end

function connect(socket::TcpSocket, host::String, port::Integer, timeoutlen::Int64)
	timeout = Time(timeoutlen)
	host_ip = IpAddress(host)
	return ccall(dlsym(libcsfml_network, :sfTcpSocket_connect), Int32, (Ptr{Void}, IpAddress, Uint16, Time,), socket.ptr, host_ip, port, timeout)
end

function disconnect(socket::TcpSocket)
	ccall(dlsym(libcsfml_network, :sfTcpSocket_disconnect), Void, (Ptr{Void},), socket.ptr)
end

function send_packet(socket::TcpSocket, packet::Packet)
	ccall(dlsym(libcsfml_network, :sfTcpSocket_sendPacket), Int32, (Ptr{Void}, Ptr{Void},), socket.ptr, packet.ptr)
end

function receive_packet(socket::TcpSocket, packet::Packet)
	nstruct = ccall(dlsym(libjuliasfml, :sjTcpSocket_receivePacket), NetworkStruct, (Ptr{Void}, Ptr{Void},), socket.ptr, packet.ptr)
	packet.ptr = nstruct.ptr
	return SocketStatus(nstruct.status)
end

export is_blocking, set_blocking, destroy, TcpSocket, connect, get_localport, receive_packet, send_packet
