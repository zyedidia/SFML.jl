type CircleShape <: Drawable
	ptr::Ptr{Void}
	_texture::Texture

	function CircleShape(ptr::Ptr{Void})
		c = new(ptr)
		finalizer(c, destroy)
		c
	end
end

function CircleShape()
	CircleShape(ccall((:sfCircleShape_create, "libcsfml-graphics"), Ptr{Void}, ()))
end

function copy(shape::CircleShape)
	return CircleShape(ccall((:sfCircleShape_copy, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function destroy(shape::CircleShape)
	ccall((:sfCircleShape_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), shape.ptr)
end

function set_position(shape::CircleShape, position::Vector2f)
	ccall((:sfCircleShape_setPosition, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), shape.ptr, position)
end

function set_rotation(shape::CircleShape, angle::Real)
	ccall((:sfCircleShape_setRotation, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), shape.ptr, angle)
end

function set_scale(shape::CircleShape, scale::Vector2f)
	ccall((:sfCircleShape_setScale, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), shape.ptr, scale)
end

function set_origin(shape::CircleShape, origin::Vector2f)
	ccall((:sfCircleShape_setOrigin, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), shape.ptr, origin)
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

function set_outline_thickness(shape::CircleShape, thickness::Real)
	ccall((:sfCircleShape_setOutlineThickness, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), shape.ptr, thickness)
end

function get_origin(shape::CircleShape)
	return ccall((:sfCircleShape_getOrigin, "libcsfml-graphics")), Vector2f, (Ptr{Void},), shape.ptr
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

function set_pointcount(shape::CircleShape, count::Int)
	ccall((:sfCircleShape_setPointCount, "libcsfml-graphics"), Void, (Ptr{Void}, Uint32,), shape.ptr, count)
end

function get_fillcolor(shape::CircleShape)
	return ccall((:sfCircleShape_getFillColor, "libcsfml-graphics"), Color, (Ptr{Void},), shape.ptr)
end

function get_outlinecolor(shape::CircleShape)
	return ccall((:sfCircleShape_getOutlineColor, "libcsfml-graphics"), Color, (Ptr{Void},), shape.ptr)
end

function get_outline_thickness(shape::CircleShape)
	return Real(ccall((:sfCircleShape_getOutlineThickness, "libcsfml-graphics"), Cfloat, (Ptr{Void},), shape.ptr))
end

function get_pointcount(shape::CircleShape)
	return Int(ccall((:sfCircleShape_getPointCount, "libcsfml-graphics"), Csize_t, (Ptr{Void},), shape.ptr))
end

function get_point(shape::CircleShape, index::Integer)
	ccall((:sfCircleShape_getPoint, "libcsfml-graphics"), Vector2f, (Ptr{Void}, Csize_t), index)
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

function set_texture(shape::CircleShape, texture::Texture)
	ccall((:sfCircleShape_setTexture, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void}, Int32,), shape.ptr, texture.ptr, false)
	shape._texture = texture
end

function set_texture_rect(shape::CircleShape, rect::IntRect)
	ccall((:sfCircleShape_setTextureRect, "libcsfml-graphics"), Void, (Ptr{Void}, IntRect,), shape.ptr, rect)
end

function get_texture(shape::CircleShape)
	return Texture(call(dlsym(libcsfml_graphics, :sfCircleShape_getTexture), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function get_texture_rect(shape::CircleShape)
	return ccall((:sfCircleShape_getTextureRect, "libcsfml-graphics"), IntRect, (Ptr{Void},), shape.ptr)
end

function get_localbounds(shape::CircleShape)
	return ccall((:sfCircleShape_getLocalBounds, "libcsfml-graphics"), FloatRect, (Ptr{Void},), shape.ptr)
end

function get_globalbounds(shape::CircleShape)
	return ccall((:sfCircleShape_getGlobalBounds, "libcsfml-graphics"), FloatRect, (Ptr{Void},), shape.ptr)
end

export CircleShape, set_position, set_radius, set_fillcolor, set_outlinecolor, move, get_position,
get_radius, set_origin, get_origin, get_fillcolor, get_outlinecolor, rotate, scale, copy, set_scale,
get_scale, set_rotation, get_rotation, get_localbounds, get_globalbounds, set_outline_thickness,
get_outline_thickness, get_pointcount, set_pointcount, get_texture_rect, get_texture, set_texture_rect, set_texture,
get_point
