type SocketTCP
	ptr::Ptr{Void}

	function SocketTCP(ptr::Ptr{Void})
		t = new(ptr)
		finalizer(t, destroy)
		t
	end
end

function SocketTCP()
	SocketTCP(ccall(dlsym(libcsfml_network, :sfTcpSocket_create), Ptr{Void}, ()))
end

function destroy(socket::SocketTCP)
	ccall(dlsym(libcsfml_network, :sfTcpSocket_destroy), Void, (Ptr{Void},), socket.ptr)
end

function set_blocking(socket::SocketTCP, blocking::Bool)
	ccall(dlsym(libcsfml_network, :sfTcpSocket_isBlocking), Void, (Ptr{Void}, Int32,), socket.ptr, blocking)
end

function is_blocking(socket::SocketTCP)
	return Bool(ccall(dlsym(libcsfml_network, :sfTcpSocket_getBlocking), Int32, (Ptr{Void},), socket.ptr))
end

function get_localport(socket::SocketTCP)
	return ccall(dlsym(libcsfml_network, :sfTcpSocket_getLocalPort), Uint16, (Ptr{Void},), socket.ptr)
end

function get_remoteaddress(socket::SocketTCP)
	to_string(ccall(dlsym(libcsfml_network, :sfTcpSocket_getRemoteAddress), IpAddress, (Ptr{Void},), socket.ptr))
end

function get_remoteport(socket::SocketTCP)
	ccall(dlsym(libcsfml_network, :sfTcpSocket_getRemotePort), Uint16, (Ptr{Void},), socket.ptr)
end

function connect(socket::SocketTCP, host::String, port::Integer, timeoutlen::Int64)
	timeout = Time(timeoutlen)
	host_ip = IpAddress(host)
	SocketStatus(ccall(dlsym(libcsfml_network, :sfTcpSocket_connect), Int32, (Ptr{Void}, IpAddress, Uint16, Time,), socket.ptr, host_ip, port, timeout))
end

function disconnect(socket::SocketTCP)
	ccall(dlsym(libcsfml_network, :sfTcpSocket_disconnect), Void, (Ptr{Void},), socket.ptr)
end

function send(socket::SocketTCP, packet::Packet)
	SocketStatus(ccall(dlsym(libcsfml_network, :sfTcpSocket_sendPacket), Int32, (Ptr{Void}, Ptr{Void},), socket.ptr, packet.ptr))
end

function receive(socket::SocketTCP, packet::Packet)
	nstruct = ccall(dlsym(libjuliasfml, :sjTcpSocket_receivePacket), NetworkStruct, (Ptr{Void}, Ptr{Void},), socket.ptr, packet.ptr)
	packet.ptr = nstruct.ptr
	return SocketStatus(nstruct.status)
end

export is_blocking, set_blocking, SocketTCP, connect, get_localport, receive, send,
disconnect, get_remoteaddress, get_remoteport
