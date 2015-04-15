type Packet
	ptr::Ptr{Void}
end

function Packet()
	return Packet(ccall(dlsym(libcsfml_network, :sfPacket_create), Ptr{Void}, ()))
end

function copy(packet::Packet)
	return Packet(ccall(dlsym(libcsfml_network, :sfPacket_copy), Ptr{Void}, (Ptr{Void},), packet.ptr))
end

function destroy(packet::Packet)
	ccall(dlsym(libcsfml_network, :sfPacket_destroy), Void, (Ptr{Void},), packet.ptr)
	packet = nothing
end

function clear(packet::Packet)
	ccall(dlsym(libcsfml_network, :sfPacket_clear), Void, (Ptr{Void},), packet.ptr)
end

function get_data_size(packet::Packet)
	return ccall(dlsym(libcsfml_network, :sfPacket_getDataSize), Int64, (Ptr{Void},), packet.ptr)
end

function read_bool(packet::Packet)
	return Bool(ccall(dlsym(libcsfml_network, :sfPacket_readBool), Uint8, (Ptr{Void},), packet.ptr))
end

function read_string(packet::Packet)
	string = ""
	string = bytestring(ccall(dlsym(libjuliasfml, :sjPacket_readString), Ptr{Cchar}, (Ptr{Void}, Ptr{Cchar},), packet.ptr, pointer(string)))
	return string
end

function read_int(packet::Packet)
	return Int(ccall(dlsym(libcsfml_network, :sfPacket_readInt32), Int32, (Ptr{Void},), packet.ptr))
end

function read_float(packet::Packet)
	return ccall(dlsym(libcsfml_network, :sfPacket_readFloat), Cfloat, (Ptr{Void},), packet.ptr)
end

function read_double(packet::Packet)
	return ccall(dlsym(libcsfml_network, :sfPacket_readDouble), Cdouble, (Ptr{Void},), packet.ptr)
end

function write_bool(packet::Packet, value::Bool)
	ccall(dlsym(libcsfml_network, :sfPacket_writeBool), Void, (Ptr{Void}, Int32,), packet.ptr, value)
end

function write_int(packet::Packet, val::Int)
	ccall(dlsym(libcsfml_network, :sfPacket_writeInt32), Void, (Ptr{Void}, Int32,), packet.ptr, val)
end

function write_float(packet::Packet, val::Cfloat)
	ccall(dlsym(libcsfml_network, :sfPacket_writeFloat), Void, (Ptr{Void}, Cfloat,), packet.ptr, val)
end

function write_double(packet::Packet, val::Cdouble)
	ccall(dlsym(libcsfml_network, :sfPacket_writeDouble), Void, (Ptr{Void}, Cdouble,), packet.ptr, val)
end

function write_string(packet::Packet, string::String)
	ccall(dlsym(libcsfml_network, :sfPacket_writeString), Void, (Ptr{Void}, Ptr{Cchar},), packet.ptr, pointer(string))
end

export Packet, copy, destroy, clear, get_data_size, read_bool, read_string, write_bool, write_string, read_double, read_float, read_int, write_int, write_float, write_double
