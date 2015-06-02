type Packet
	ptr::Ptr{Void}

	function Packet(ptr::Ptr{Void})
		p = new(ptr)
		finalizer(p, destroy)
		p
	end
end

function Packet()
	Packet(ccall((:sfPacket_create, "libcsfml-network"), Ptr{Void}, ()))
end

function copy(packet::Packet)
	return Packet(ccall((:sfPacket_copy, "libcsfml-network"), Ptr{Void}, (Ptr{Void},), packet.ptr))
end

function destroy(packet::Packet)
	ccall((:sfPacket_destroy, "libcsfml-network"), Void, (Ptr{Void},), packet.ptr)
end

function clear(packet::Packet)
	ccall((:sfPacket_clear, "libcsfml-network"), Void, (Ptr{Void},), packet.ptr)
end

function get_data_size(packet::Packet)
	return ccall((:sfPacket_getDataSize, "libcsfml-network"), Int64, (Ptr{Void},), packet.ptr)
end

function read_bool(packet::Packet)
	return Bool(ccall((:sfPacket_readBool, "libcsfml-network"), Uint8, (Ptr{Void},), packet.ptr))
end

function read_string(packet::Packet)
	string = ""
	string = bytestring(ccall((:sjPacket_readString, "libjuliasfml"), Ptr{Cchar}, (Ptr{Void}, Ptr{Cchar},), packet.ptr, string))
	return string
end

function read_int(packet::Packet)
	return Int(ccall((:sfPacket_readInt32, "libcsfml-network"), Int32, (Ptr{Void},), packet.ptr))
end

function read_float(packet::Packet)
	return ccall((:sfPacket_readFloat, "libcsfml-network"), Cfloat, (Ptr{Void},), packet.ptr)
end

function read_double(packet::Packet)
	return ccall((:sfPacket_readDouble, "libcsfml-network"), Cdouble, (Ptr{Void},), packet.ptr)
end

function write(packet::Packet, value::Bool)
	ccall((:sfPacket_writeBool, "libcsfml-network"), Void, (Ptr{Void}, Int32,), packet.ptr, value)
end

function write(packet::Packet, val::Integer)
	ccall((:sfPacket_writeInt32, "libcsfml-network"), Void, (Ptr{Void}, Int32,), packet.ptr, val)
end

function write(packet::Packet, val::Cfloat)
	ccall((:sfPacket_writeFloat, "libcsfml-network"), Void, (Ptr{Void}, Cfloat,), packet.ptr, val)
end

function write(packet::Packet, val::Cdouble)
	ccall((:sfPacket_writeDouble, "libcsfml-network"), Void, (Ptr{Void}, Cdouble,), packet.ptr, val)
end

function write(packet::Packet, string::String)
	ccall((:sfPacket_writeString, "libcsfml-network"), Void, (Ptr{Void}, Ptr{Cchar},), packet.ptr, string)
end

export Packet, copy, clear, get_data_size, read_bool, read_string, read_double, write
read_float, read_int
