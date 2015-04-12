type Vector2i
	x::Cint
	y::Cint
end
type Vector2u
	ptr::Ptr{Void}
end
type Vector2f
	x::Cfloat
	y::Cfloat
end

export Vector2i, Vector2f, Vector2
