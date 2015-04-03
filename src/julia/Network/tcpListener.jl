type TcpListener
	ptr::Ptr{Void}
end

function TcpListener()
	return TcpListener(ccall((:sfTcpListener_create, "libcsfml-network"), Ptr{Void}, ()))
end

function destroy(listener::TcpListener)
	ccall((:sfTcpListener_destroy, "libcsfml-network"), Void, (Ptr{Void},), listener.ptr)
	listener = nothing
end

function set_blocking(listener::TcpListener, blocking::Bool)
	ccall((:sfTcpListener_setBlocking, "libcsfml-network"), Void, (Ptr{Void}, Int32,), listener.ptr, blocking)
end

function is_blocking(listener::TcpListener)
	return ccall((:sfTcpListener_isBlocking, "libcsfml-network"), Int32, (Ptr{Void},), listener.ptr) == 1
end

function get_localport(listener::TcpListener)
	return Int(ccall((:sfTcpListener_getLocalPort, "libcsfml-network"), Uint16, (Ptr{Void},), listener.ptr))
end

function listen(listener::TcpListener, port::Int)
	return ccall((:sfTcpListener_listen, "libcsfml-network"), Int32, (Ptr{Void}, Uint16,), listener.ptr, port)
end

function accept(listener::TcpListener, connected::TcpSocket)
	ccall((:sfTcpListener_accept, "libcsfml-network"), Int32, (Ptr{Void}, Ptr{Void},), listener.ptr, connected.ptr)
end

export accept, listen, get_localport, is_blocking, set_blocking, destroy, TcpListener
