abstract Vector2
type Vector2i <: Vector2
	x::Cint
	y::Cint
end
type Vector2u <: Vector2
	x::Uint32
	y::Uint32
end
type Vector2f <: Vector2
	x::Cfloat
	y::Cfloat
end

function to_vec2u(vec::Vector2)
	return Vector2u(Uint32(vec.x), Uint32(vec.y))
end

function to_vec2f(vec::Vector2)
	return Vector2f(Float32(vec.x), Float32(vec.y))
end

function to_vec2i(vec::Vector2)
	return Vector2i(Int32(vec.x), Int32(vec.y))
end

function distance(vec1::Vector2, vec2::Vector2)
	return sqrt((vec2.x - vec1.x)^2 + (vec2.y - vec1.y)^2)
end

export Vector2i, Vector2f, Vector2u, to_vec2u, to_vec2f, to_vec2i, distance
