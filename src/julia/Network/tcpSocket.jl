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

export is_blocking, set_blocking, destroy, TcpSocket
