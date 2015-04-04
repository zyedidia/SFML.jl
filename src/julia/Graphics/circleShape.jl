type CircleShape
	ptr::Ptr{Void}
end

function CircleShape()
	return CircleShape(ccall(dlsym(libcsfml_graphics, :sfCircleShape_create), Ptr{Void}, ()))
end

function copy(shape::CircleShape)
	return CircleShape(ccall(dlsym(libcsfml_graphics, :sfCircleShape_copy), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function destroy(shape::CircleShape)
	ccall(dlsym(libcsfml_graphics, :sfCircleShape_destroy), Void, (Ptr{Void},), shape.ptr)
	shape = nothing
end

function set_origin(shape::CircleShape, origin::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfCircleShape_setOrigin), Void, (Ptr{Void}, Vector2f,), shape.ptr, origin)
end

function set_scale(shape::CircleShape, scale::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfCircleShape_setScale), Void, (Ptr{Void}, Vector2f,), shape.ptr, scale)
end

function set_rotation(shape::CircleShape, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfCircleShape_setRotation), Void, (Ptr{Void}, Cfloat,), shape.ptr, angle)
end

function set_position(shape::CircleShape, position::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfCircleShape_setPosition), Void, (Ptr{Void}, Vector2f,), shape.ptr, position)
end

function set_radius(shape::CircleShape, radius::Real)
	ccall(dlsym(libcsfml_graphics, :sfCircleShape_setRadius), Void, (Ptr{Void}, Cfloat,), shape.ptr, radius)
end

function set_fillcolor(shape::CircleShape, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfCircleShape_setFillColor), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function set_outlinecolor(shape::CircleShape, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfCircleShape_setOutlineColor), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function get_origin(shape::CircleShape)
	return ccall(dlsym(libcsfml_graphics, :sfCircleShape_getOrigin)), Vector2f, (Ptr{Void},), shape.ptr
end

function get_scale(shape::CircleShape)
	return ccall(dlsym(libcsfml_graphics, :sfCircleShape_getScale), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_rotation(shape::CircleShape)
	return Real(ccall(dlsym(libcsfml_graphics, :sfCircleShape_getRotation), Cfloat, (Ptr{Void},), shape.ptr))
end

function get_position(shape::CircleShape)
	return ccall(dlsym(libcsfml_graphics, :sfCircleShape_getPosition), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_radius(shape::CircleShape)
	return real(ccall(dlsym(libcsfml_graphics, :sfCircleShape_getRadius), Cfloat, (Ptr{Void},), shape.ptr))
end

function get_fillcolor(shape::CircleShape)
	return ccall(dlsym(libcsfml_graphics, :sfCircleShape_getFillColor), Color, (Ptr{Void},), shape.ptr)
end

function get_outlinecolor(shape::CircleShape)
	return ccall(dlsym(libcsfml_graphics, :sfCircleShape_getOutlineColor), Color, (Ptr{Void},), shape.ptr)
end

function move(shape::CircleShape, offset::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfCircleShape_move), Void, (Ptr{Void}, Vector2f,), shape.ptr, offset)
end

function scale(shape::CircleShape, factors::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfCircleShape_scale), Void, (Ptr{Void}, Vector2f,), shape.ptr, factors)
end

function rotate(shape::CircleShape, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfCircleShape_rotate), Void, (Ptr{Void}, Cfloat,), shape.ptr, angle)
end

function get_localbounds(shape::CircleShape)
	return ccall(dlsym(libcsfml_graphics, :sfCircleShape_getLocalBounds), FloatRect, (Ptr{Void},), shape.ptr)
end

function get_globalbounds(shape::CircleShape)
	return ccall(dlsym(libcsfml_graphics, :sfCircleShape_getGlobalBounds), FloatRect, (Ptr{Void},), shape.ptr)
end

export CircleShape, set_position, set_radius, set_fillcolor, set_outlinecolor, move, get_position, get_radius, set_origin, get_origin, get_fillcolor, get_outlinecolor, rotate, scale, copy, set_scale, get_scale, set_rotation, get_rotation, get_localbounds, get_globalbounds
