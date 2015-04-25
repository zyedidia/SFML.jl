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

type VertexArray
	ptr::Ptr{Void}
end

function VertexArray()
	return VertexArray(ccall(dlsym(libcsfml_graphics, :sfVertexArray_create), Ptr{Void}, ()))
end

function copy(arr::VertexArray)
	return VertexArray(ccall(dlsym(libcsfml_graphics, :sfVertexArray_copy), Ptr{Void}, (Ptr{Void},), arr.ptr))
end

function destroy(arr::VertexArray)
	ccall(dlsym(libcsfml_graphics, :sfVertexArray_destroy), Void, (Ptr{Void},), arr.ptr)
end

function get_vertexcount(arr::VertexArray)
	return Int(ccall(dlsym(libcsfml_graphics, :sfVertexArray_getVertexCount), Uint32, (Ptr{Void},), arr.ptr))
end

function get_vertex(arr::VertexArray, index::Integer)
	ptr = ccall(dlsym(libcsfml_graphics, :sfVertexArray_getVertex), Ptr{Vertex}, (Ptr{Void}, Uint32,), arr.ptr, index)
	return unsafe_load(ptr)
end

function clear(arr::VertexArray)
	ccall(dlsym(libcsfml_graphics, :sfVertexArray_clear), Void, (Ptr{Void},), arr.ptr)
end

function resize(arr::VertexArray, vertex_count::Integer)
	ccall(dlsym(libcsfml_graphics, :sfVertexArray_resize), Void, (Ptr{Void}, Uint32,), arr.ptr, vertex_count)
end

function append(arr::VertexArray, vertex::Vertex)
	ccall(dlsym(libcsfml_graphics, :sfVertexArray_append), Void, (Ptr{Void}, Vertex,), arr.ptr, vertex)
end

function set_primitive_type(arr::VertexArray, primitive_type::PrimitiveType)
	ccall(dlsym(libcsfml_graphics, :sfVertexArray_setPrimitiveType), Void, (Ptr{Void}, Int32,), arr.ptr, Int32(primitive_type))
end

function get_primitive_type(arr::VertexArray)
	return PrimitiveType(ccall(libcsfml_graphics, :sfVertexArray_getPrimitiveType), Int32, (Ptr{Void},), arr.ptr)
end

function getbounds(arr::VertexArray)
	return ccall(dlsym(libcsfml_graphics, :sfVertexArray_getBounds), FloatRect, (Ptr{Void},), arr.ptr)
end

export PrimitiveType, VertexArray, Vertex, copy, destroy, get_vertexcount, get_vertex, clear, resize, append,
set_primitive_type, get_primitive_type, getbounds
