mutable struct TcpListener
    ptr::Ptr{Nothing}

    function TcpListener(ptr::Ptr{Nothing})
        t = new(ptr)
        finalizer(t, destroy)
        t
    end
end

function TcpListener()
    TcpListener(ccall((:sfTcpListener_create, libcsfml_network), Ptr{Nothing}, ()))
end

function destroy(listener::TcpListener)
    ccall((:sfTcpListener_destroy, libcsfml_network), Nothing, (Ptr{Nothing},), listener.ptr)
end

function set_blocking(listener::TcpListener, blocking::Bool)
    ccall((:sfTcpListener_setBlocking, libcsfml_network), Nothing, (Ptr{Nothing}, Int32,), listener.ptr, blocking)
end

function is_blocking(listener::TcpListener)
    return ccall((:sfTcpListener_isBlocking, libcsfml_network), Int32, (Ptr{Nothing},), listener.ptr) == 1
end

function get_localport(listener::TcpListener)
    return ccall((:sfTcpListener_getLocalPort, libcsfml_network), UInt16, (Ptr{Nothing},), listener.ptr)
end

function listen(listener::TcpListener, port::Integer)
    SocketStatus(ccall((:sfTcpListener_listen, libcsfml_network), Int32, (Ptr{Nothing}, UInt16,), listener.ptr, port))
end

function accept(listener::TcpListener, socket::SocketTCP)
    nstruct = ccall((:sjTcpListener_accept, "libjuliasfml"), NetworkStruct, (Ptr{Nothing}, Ptr{Nothing},), listener.ptr, socket.ptr)
    socket.ptr = nstruct.ptr
    return SocketStatus(nstruct.status)
end
