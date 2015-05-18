type SocketUDP
	ptr::Ptr{Void}

	function SocketUDP(ptr::Ptr{Void})
		s = new(ptr)
		finalizer(s, destroy)
		s
	end
end

function SocketUDP()
	SocketUDP(ccall(dlsym(libcsfml_network, :sfUdpSocket_create), Ptr{Void} ()))
end

function destroy(socket::SocketUDP)
	ccall(dlsym(libcsfml_network, :sfUdpSocket_create), Void, (Ptr{Void},), socket.ptr)
end

function set_blocking(socket::SocketUDP, blocking::Bool)
	ccall(dlsym(libcsfml_network, :sfUdpSocket_setBlocking), Void, (Ptr{Void}, Int32,), socket.ptr, blocking)
end

function is_blocking(socket::SocketUDP)
	Bool(ccall(dlsym(libcsfml_network, :sfUdpSocket_isBlocking), Int32, (Ptr{Void},), socket.ptr))
end

function get_localport(socket::SocketUDP)
	Int(ccall(dlsym(libcsfml_network, :sfUdpSocket_getLocalPort), Uint16, (Ptr{Void},), socket.ptr))
end

function bind(socket::SocketUDP, port::Integer)
	ccall(dlsym(libcsfml_network, :sfUdpSocket_bind), Void, (Ptr{Void}, Uint16,), socket.ptr, port)
end

function unbind(socket::SocketUDP)
	ccall(dlsym(libcsfml_network, :sfUdpSocket_unbind), Void, (Ptr{Void},), socket.ptr)
end

function send(socket::SocketUDP, packet::Packet, ipaddress::IpAddress, port::Integer)
	SocketStatus(ccall(dlsym(libcsfml_network, :sfUdpSocket_sendPacket), Int32, (Ptr{Void}, Ptr{Void}, IpAddress, Uint16,), socket.ptr, packet.ptr, ipaddress, port))
end

function receive(socket::SocketUDP, packet::Packet, ipaddress::IpAddress, port::Uint16)
	ipaddress_ptr = pointer_from_objref(IpAddress)
	status = SocketStatus(ccall(dlsym(libcsfml_network, :sfUdpSocket_receivePacket), Int32, (Ptr{Void}, Ptr{Void}, Ptr{IpAddress}, Ptr{Uint16},), socket.ptr, packet.ptr, ipaddress_ptr, port_ptr))
	status
end

function max_datagram_size()
	ccall(dlsym(libcsfml_network, :sfUdpSocket_maxDatagramSize), Uint32, ())
end

export SocketUDP, set_blocking, is_blocking, get_localport, bind, unbind, send, receive, max_datagram_size
