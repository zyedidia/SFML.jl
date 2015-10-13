type TcpListener
    ptr::Ptr{Void}

    function TcpListener(ptr::Ptr{Void})
        t = new(ptr)
        finalizer(t, destroy)
        t
    end
end

function TcpListener()
    TcpListener(ccall((:sfTcpListener_create, libcsfml_network), Ptr{Void}, ()))
end

function destroy(listener::TcpListener)
    ccall((:sfTcpListener_destroy, libcsfml_network), Void, (Ptr{Void},), listener.ptr)
end

function set_blocking(listener::TcpListener, blocking::Bool)
    ccall((:sfTcpListener_setBlocking, libcsfml_network), Void, (Ptr{Void}, Int32,), listener.ptr, blocking)
end

function is_blocking(listener::TcpListener)
    return ccall((:sfTcpListener_isBlocking, libcsfml_network), Int32, (Ptr{Void},), listener.ptr) == 1
end

function get_localport(listener::TcpListener)
    return ccall((:sfTcpListener_getLocalPort, libcsfml_network), UInt16, (Ptr{Void},), listener.ptr)
end

function listen(listener::TcpListener, port::Integer)
    SocketStatus(ccall((:sfTcpListener_listen, libcsfml_network), Int32, (Ptr{Void}, UInt16,), listener.ptr, port))
end

function accept(listener::TcpListener, socket::SocketTCP)
    nstruct = ccall((:sjTcpListener_accept, "libjuliasfml"), NetworkStruct, (Ptr{Void}, Ptr{Void},), listener.ptr, socket.ptr)
    socket.ptr = nstruct.ptr
    return SocketStatus(nstruct.status)
end
