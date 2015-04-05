type TcpListener
	ptr::Ptr{Void}
end

function TcpListener()
	return TcpListener(ccall(dlsym(libcsfml_network, :sfTcpListener_create), Ptr{Void}, ()))
end

function destroy(listener::TcpListener)
	ccall(dlsym(libcsfml_network, :sfTcpListener_destroy), Void, (Ptr{Void},), listener.ptr)
	listener = nothing
end

function set_blocking(listener::TcpListener, blocking::Bool)
	ccall(dlsym(libcsfml_network, :sfTcpListener_setBlocking), Void, (Ptr{Void}, Int32,), listener.ptr, blocking)
end

function is_blocking(listener::TcpListener)
	return ccall(dlsym(libcsfml_network, :sfTcpListener_isBlocking), Int32, (Ptr{Void},), listener.ptr) == 1
end

function get_localport(listener::TcpListener)
	return Int(ccall(dlsym(libcsfml_network, :sfTcpListener_getLocalPort), Uint16, (Ptr{Void},), listener.ptr))
end

function listen(listener::TcpListener, port::Int)
	return SocketStatus(ccall(dlsym(libcsfml_network, :sfTcpListener_listen), Int32, (Ptr{Void}, Uint16,), listener.ptr, port))
end

function accept(listener::TcpListener)
	socket = TcpSocket()
	socket.ptr = ccall(dlsym(libjuliasfml, :sjTcpListener_accept), Ptr{Void}, (Ptr{Void}, Ptr{Void},), listener.ptr, socket.ptr)
	return socket
end

export accept, listen, get_localport, is_blocking, set_blocking, destroy, TcpListener
