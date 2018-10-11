mutable struct Packet
    ptr::Ptr{Nothing}

    function Packet(ptr::Ptr{Nothing})
        p = new(ptr)
        finalizer(p, destroy)
        p
    end
end

function Packet()
    Packet(ccall((:sfPacket_create, libcsfml_network), Ptr{Nothing}, ()))
end

function copy(packet::Packet)
    return Packet(ccall((:sfPacket_copy, libcsfml_network), Ptr{Nothing}, (Ptr{Nothing},), packet.ptr))
end

function destroy(packet::Packet)
    ccall((:sfPacket_destroy, libcsfml_network), Nothing, (Ptr{Nothing},), packet.ptr)
end

function clear(packet::Packet)
    ccall((:sfPacket_clear, libcsfml_network), Nothing, (Ptr{Nothing},), packet.ptr)
end

function get_data_size(packet::Packet)
    return ccall((:sfPacket_getDataSize, libcsfml_network), Int64, (Ptr{Nothing},), packet.ptr)
end

function read_bool(packet::Packet)
    return Bool(ccall((:sfPacket_readBool, libcsfml_network), UInt8, (Ptr{Nothing},), packet.ptr))
end

function read_string(packet::Packet)
    str = ""
    str = bytestring(ccall((:sjPacket_readString, "libjuliasfml"), Ptr{Cchar}, (Ptr{Nothing}, Ptr{Cchar},), packet.ptr, str))
    return str
end

function read_int(packet::Packet)
    return Int(ccall((:sfPacket_readInt32, libcsfml_network), Int32, (Ptr{Nothing},), packet.ptr))
end

function read_float(packet::Packet)
    return ccall((:sfPacket_readFloat, libcsfml_network), Cfloat, (Ptr{Nothing},), packet.ptr)
end

function read_double(packet::Packet)
    return ccall((:sfPacket_readDouble, libcsfml_network), Cdouble, (Ptr{Nothing},), packet.ptr)
end

function write(packet::Packet, value::Bool)
    ccall((:sfPacket_writeBool, libcsfml_network), Nothing, (Ptr{Nothing}, Int32,), packet.ptr, value)
end

function write(packet::Packet, val::Integer)
    ccall((:sfPacket_writeInt32, libcsfml_network), Nothing, (Ptr{Nothing}, Int32,), packet.ptr, val)
end

function write(packet::Packet, val::Cfloat)
    ccall((:sfPacket_writeFloat, libcsfml_network), Nothing, (Ptr{Nothing}, Cfloat,), packet.ptr, val)
end

function write(packet::Packet, val::Cdouble)
    ccall((:sfPacket_writeDouble, libcsfml_network), Nothing, (Ptr{Nothing}, Cdouble,), packet.ptr, val)
end

function write(packet::Packet, string::AbstractString)
    ccall((:sfPacket_writeString, libcsfml_network), Nothing, (Ptr{Nothing}, Ptr{Cchar},), packet.ptr, string)
end

