type TcpSocket
	ptr::Ptr{Void}
end

function TcpSocket()
	return TcpSocket(ccall((:sfTcpSocket_create, "libcsfml-network"), Ptr{Void}, ()))
end

function destroy(socket::TcpSocket)
	ccall((:sfTcpSocket_destroy, "libcsfml-network"), Void, (Ptr{Void},), socket.ptr)
	socket = nothing
end

function set_blocking(socket::TcpSocket, blocking::Bool)
	ccall((:sfTcpSocket_isBlocking, "libcsfml-network"), Void, (Ptr{Void}, Int32,), socket.ptr, blocking)
end

function is_blocking(socket::TcpSocket)
	return ccall((:sfTcpSocket_getBlocking, "libcsfml-network"), Int32, (Ptr{Void},), socket.ptr) == 1
end

