type SocketUDP
    ptr::Ptr{Void}

    function SocketUDP(ptr::Ptr{Void})
        s = new(ptr)
        finalizer(s, destroy)
        s
    end
end

function SocketUDP()
    SocketUDP(ccall((:sfUdpSocket_create, libcsfml_network), Ptr{Void}, ()))
end

function destroy(socket::SocketUDP)
    ccall((:sfUdpSocket_create, libcsfml_network), Void, (Ptr{Void},), socket.ptr)
end

function set_blocking(socket::SocketUDP, blocking::Bool)
    ccall((:sfUdpSocket_setBlocking, libcsfml_network), Void, (Ptr{Void}, Int32,), socket.ptr, blocking)
end

function is_blocking(socket::SocketUDP)
    Bool(ccall((:sfUdpSocket_isBlocking, libcsfml_network), Int32, (Ptr{Void},), socket.ptr))
end

function get_localport(socket::SocketUDP)
    Int(ccall((:sfUdpSocket_getLocalPort, libcsfml_network), UInt16, (Ptr{Void},), socket.ptr))
end

function bind(socket::SocketUDP, port::Integer)
    ccall((:sfUdpSocket_bind, libcsfml_network), Void, (Ptr{Void}, UInt16,), socket.ptr, port)
end

function unbind(socket::SocketUDP)
    ccall((:sfUdpSocket_unbind, libcsfml_network), Void, (Ptr{Void},), socket.ptr)
end

function send(socket::SocketUDP, packet::Packet, ipaddress::IpAddress, port::Integer)
    SocketStatus(ccall((:sfUdpSocket_sendPacket, libcsfml_network), Int32, (Ptr{Void}, Ptr{Void}, IpAddress, UInt16,), socket.ptr, packet.ptr, ipaddress, port))
end

function receive(socket::SocketUDP, packet::Packet, ipaddress::IpAddress, port::UInt16)
    ipaddress_ptr = pointer_from_objref(ipaddress)
    status = SocketStatus(ccall((:sfUdpSocket_receivePacket, libcsfml_network), Int32, (Ptr{Void}, Ptr{Void}, Ptr{IpAddress}, Ref{UInt16},), socket.ptr, packet.ptr, ipaddress_ptr, Ref(port)))
    status
end

function max_datagram_size()
    ccall((:sfUdpSocket_maxDatagramSize, libcsfml_network), UInt32, ())
end

