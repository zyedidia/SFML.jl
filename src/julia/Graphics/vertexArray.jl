@enum(PrimitiveType,
points,
lines,
linesStrip,
triangles,
trianglesStrip,
triangleFan,
quads)

type Vertex
    position::Vector2f
    color::Color
    texCoords::Vector2f
end

type VertexArray <: Drawable
    ptr::Ptr{Void}

    function VertexArray(ptr::Ptr{Void})
        v = new(ptr)
        finalizer(v, destroy)
        v
    end
end

function VertexArray()
    VertexArray(ccall((:sfVertexArray_create, "libcsfml-graphics"), Ptr{Void}, ()))
end

function copy(arr::VertexArray)
    return VertexArray(ccall((:sfVertexArray_copy, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), arr.ptr))
end

function destroy(arr::VertexArray)
    ccall((:sfVertexArray_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), arr.ptr)
end

function get_vertexcount(arr::VertexArray)
    return Int(ccall((:sfVertexArray_getVertexCount, "libcsfml-graphics"), Uint32, (Ptr{Void},), arr.ptr))
end

function get_vertex(arr::VertexArray, index::Integer)
    ptr = ccall((:sfVertexArray_getVertex, "libcsfml-graphics"), Ptr{Vertex}, (Ptr{Void}, Uint32,), arr.ptr, index)
    return unsafe_load(ptr)
end

function clear(arr::VertexArray)
    ccall((:sfVertexArray_clear, "libcsfml-graphics"), Void, (Ptr{Void},), arr.ptr)
end

function resize(arr::VertexArray, vertex_count::Integer)
    ccall((:sfVertexArray_resize, "libcsfml-graphics"), Void, (Ptr{Void}, Uint32,), arr.ptr, vertex_count)
end

function append(arr::VertexArray, vertex::Vertex)
    ccall((:sfVertexArray_append, "libcsfml-graphics"), Void, (Ptr{Void}, Vertex,), arr.ptr, vertex)
end

function set_primitive_type(arr::VertexArray, primitive_type::PrimitiveType)
    ccall((:sfVertexArray_setPrimitiveType, "libcsfml-graphics"), Void, (Ptr{Void}, Int32,), arr.ptr, Int32(primitive_type))
end

function get_primitive_type(arr::VertexArray)
    return PrimitiveType(ccall(libcsfml_graphics, :sfVertexArray_getPrimitiveType), Int32, (Ptr{Void},), arr.ptr)
end

function getbounds(arr::VertexArray)
    return ccall((:sfVertexArray_getBounds, "libcsfml-graphics"), FloatRect, (Ptr{Void},), arr.ptr)
end
