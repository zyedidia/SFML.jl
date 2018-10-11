mutable struct SocketTCP
    ptr::Ptr{Nothing}

    function SocketTCP(ptr::Ptr{Nothing})
        t = new(ptr)
        finalizer(t, destroy)
        t
    end
end

function SocketTCP()
    SocketTCP(ccall((:sfTcpSocket_create, libcsfml_network), Ptr{Nothing}, ()))
end

function destroy(socket::SocketTCP)
    ccall((:sfTcpSocket_destroy, libcsfml_network), Nothing, (Ptr{Nothing},), socket.ptr)
end

function set_blocking(socket::SocketTCP, blocking::Bool)
    ccall((:sfTcpSocket_isBlocking, libcsfml_network), Nothing, (Ptr{Nothing}, Int32,), socket.ptr, blocking)
end

function is_blocking(socket::SocketTCP)
    return Bool(ccall((:sfTcpSocket_getBlocking, libcsfml_network), Int32, (Ptr{Nothing},), socket.ptr))
end

function get_localport(socket::SocketTCP)
    return ccall((:sfTcpSocket_getLocalPort, libcsfml_network), UInt16, (Ptr{Nothing},), socket.ptr)
end

function get_remoteaddress(socket::SocketTCP)
    to_string(ccall((:sfTcpSocket_getRemoteAddress, libcsfml_network), IpAddress, (Ptr{Nothing},), socket.ptr))
end

function get_remoteport(socket::SocketTCP)
    ccall((:sfTcpSocket_getRemotePort, libcsfml_network), UInt16, (Ptr{Nothing},), socket.ptr)
end

function connect(socket::SocketTCP, host::AbstractString, port::Integer, timeoutlen::Int64)
    timeout = Time(timeoutlen)
    host_ip = IpAddress(host)
    SocketStatus(ccall((:sfTcpSocket_connect, libcsfml_network), Int32, (Ptr{Nothing}, IpAddress, UInt16, Time,), socket.ptr, host_ip, port, timeout))
end

function disconnect(socket::SocketTCP)
    ccall((:sfTcpSocket_disconnect, libcsfml_network), Nothing, (Ptr{Nothing},), socket.ptr)
end

function send(socket::SocketTCP, packet::Packet)
    SocketStatus(ccall((:sfTcpSocket_sendPacket, libcsfml_network), Int32, (Ptr{Nothing}, Ptr{Nothing},), socket.ptr, packet.ptr))
end

function receive(socket::SocketTCP, packet::Packet)
    nstruct = ccall((:sjTcpSocket_receivePacket, "libjuliasfml"), NetworkStruct, (Ptr{Nothing}, Ptr{Nothing},), socket.ptr, packet.ptr)
    packet.ptr = nstruct.ptr
    return SocketStatus(nstruct.status)
end
