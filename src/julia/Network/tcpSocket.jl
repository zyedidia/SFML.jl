type SocketTCP
	ptr::Ptr{Void}

	function SocketTCP(ptr::Ptr{Void})
		t = new(ptr)
		finalizer(t, destroy)
		t
	end
end

function SocketTCP()
	SocketTCP(ccall((:sfTcpSocket_create, "libcsfml-network"), Ptr{Void}, ()))
end

function destroy(socket::SocketTCP)
	ccall((:sfTcpSocket_destroy, "libcsfml-network"), Void, (Ptr{Void},), socket.ptr)
end

function set_blocking(socket::SocketTCP, blocking::Bool)
	ccall((:sfTcpSocket_isBlocking, "libcsfml-network"), Void, (Ptr{Void}, Int32,), socket.ptr, blocking)
end

function is_blocking(socket::SocketTCP)
	return Bool(ccall((:sfTcpSocket_getBlocking, "libcsfml-network"), Int32, (Ptr{Void},), socket.ptr))
end

function get_localport(socket::SocketTCP)
	return ccall((:sfTcpSocket_getLocalPort, "libcsfml-network"), Uint16, (Ptr{Void},), socket.ptr)
end

function get_remoteaddress(socket::SocketTCP)
	to_string(ccall((:sfTcpSocket_getRemoteAddress, "libcsfml-network"), IpAddress, (Ptr{Void},), socket.ptr))
end

function get_remoteport(socket::SocketTCP)
	ccall((:sfTcpSocket_getRemotePort, "libcsfml-network"), Uint16, (Ptr{Void},), socket.ptr)
end

function connect(socket::SocketTCP, host::String, port::Integer, timeoutlen::Int64)
	timeout = Time(timeoutlen)
	host_ip = IpAddress(host)
	SocketStatus(ccall((:sfTcpSocket_connect, "libcsfml-network"), Int32, (Ptr{Void}, IpAddress, Uint16, Time,), socket.ptr, host_ip, port, timeout))
end

function disconnect(socket::SocketTCP)
	ccall((:sfTcpSocket_disconnect, "libcsfml-network"), Void, (Ptr{Void},), socket.ptr)
end

function send(socket::SocketTCP, packet::Packet)
	SocketStatus(ccall((:sfTcpSocket_sendPacket, "libcsfml-network"), Int32, (Ptr{Void}, Ptr{Void},), socket.ptr, packet.ptr))
end

function receive(socket::SocketTCP, packet::Packet)
	nstruct = ccall((:sjTcpSocket_receivePacket, "libjuliasfml"), NetworkStruct, (Ptr{Void}, Ptr{Void},), socket.ptr, packet.ptr)
	packet.ptr = nstruct.ptr
	return SocketStatus(nstruct.status)
end
