type CircleShape
	ptr::Ptr{Void}
end

function CircleShape()
	return CircleShape(ccall((:sfCircleShape_create, "libcsfml-graphics"), Ptr{Void}, ()))
end

function copy(shape::CircleShape)
	return CircleShape(ccall((:sfCircleShape_copy, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function destroy(shape::CircleShape)
	ccall((:sfCircleShape_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), shape.ptr)
	shape = nothing
end

function set_origin(shape::CircleShape, origin::Vector2f)
	ccall((:sfCircleShape_setOrigin, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), shape.ptr, origin)
end

function set_scale(shape::CircleShape, scale::Vector2f)
	ccall((:sfCircleShape_setScale, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), shape.ptr, scale)
end

function set_rotation(shape::CircleShape, angle::Real)
	ccall((:sfCircleShape_setRotation, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), shape.ptr, angle)
end

function set_position(shape::CircleShape, position::Vector2f)
	ccall((:sfCircleShape_setPosition, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), shape.ptr, position)
end

function set_radius(shape::CircleShape, radius::Real)
	ccall((:sfCircleShape_setRadius, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), shape.ptr, radius)
end

function set_fillcolor(shape::CircleShape, color::Color)
	ccall((:sfCircleShape_setFillColor, "libcsfml-graphics"), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function set_outlinecolor(shape::CircleShape, color::Color)
	ccall((:sfCircleShape_setOutlineColor, "libcsfml-graphics"), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function get_origin(shape::CircleShape)
	return ccall((:sfCircleShape_getOrigin), "libcsfml-graphics"), Vector2f, (Ptr{Void},), shape.ptr
end

function get_scale(shape::CircleShape)
	return ccall((:sfCircleShape_getScale, "libcsfml-graphics"), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_rotation(shape::CircleShape)
	return Real(ccall((:sfCircleShape_getRotation, "libcsfml-graphics"), Cfloat, (Ptr{Void},), shape.ptr))
end

function get_position(shape::CircleShape)
	return ccall((:sfCircleShape_getPosition, "libcsfml-graphics"), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_radius(shape::CircleShape)
	return real(ccall((:sfCircleShape_getRadius, "libcsfml-graphics"), Cfloat, (Ptr{Void},), shape.ptr))
end

function get_fillcolor(shape::CircleShape)
	return ccall((:sfCircleShape_getFillColor, "libcsfml-graphics"), Color, (Ptr{Void},), shape.ptr)
end

function get_outlinecolor(shape::CircleShape)
	return ccall((:sfCircleShape_getOutlineColor, "libcsfml-graphics"), Color, (Ptr{Void},), shape.ptr)
end

function move(shape::CircleShape, offset::Vector2f)
	ccall((:sfCircleShape_move, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), shape.ptr, offset)
end

function scale(shape::CircleShape, factors::Vector2f)
	ccall((:sfCircleShape_scale, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), shape.ptr, factors)
end

function rotate(shape::CircleShape, angle::Real)
	ccall((:sfCircleShape_rotate, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), shape.ptr, angle)
end

function get_localbounds(shape::CircleShape)
	return ccall((:sfCircleShape_getLocalBounds, "libcsfml-graphics"), FloatRect, (Ptr{Void},), shape.ptr)
end

function get_globalbounds(shape::CircleShape)
	return ccall((:sfCircleShape_getGlobalBounds, "libcsfml-graphics"), FloatRect, (Ptr{Void},), shape.ptr)
end

export CircleShape, set_position, set_radius, set_fillcolor, set_outlinecolor, move, get_position, get_radius, set_origin, get_origin, get_fillcolor, get_outlinecolor, rotate, scale, copy, set_scale, get_scale, set_rotation, get_rotation, get_localbounds, get_globalbounds
