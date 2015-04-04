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
	return Int(ccall(dlsym(libcsfml_network, :sfTcpSocket_getLocalPort), Uint16, (Ptr{Void},), socket.ptr))
end

function connect(socket::TcpSocket, host::ASCIIString, port::Int, timeoutlen::Int64)
	timeout = Time(timeoutlen)
	hostIp = IpAddress(host)
	return ccall(dlsym(libcsfml_network, :sfTcpSocket_connect), Int32, (Ptr{Void}, IpAddress, Uint16, Time,), socket.ptr, hostIp, port, timeout)
end

export is_blocking, set_blocking, destroy, TcpSocket, connect, get_localport
