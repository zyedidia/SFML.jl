type RectangleShape
	ptr::Ptr{Void}
end

function RectangleShape()
	return RectangleShape(ccall(dlsym(libcsfml_graphics, :sfRectangleShape_create), Ptr{Void}, ()))
end

function copy(shape::RectangleShape)
	return RectangleShape(ccall(dlsym(libcsfml_graphics, :sfRectangleShape_copy), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function destroy(shape::RectangleShape)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_destroy), Void, (Ptr{Void},), shape.ptr)
	shape = nothing
end

function set_position(shape::RectangleShape, position::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_setPosition), Void, (Ptr{Void}, Vector2f,), shape.ptr, position)
end

function set_rotation(shape::RectangleShape, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_setRotation), Void, (Ptr{Void}, Cfloat), shape.ptr, angle)
end

function set_scale(shape::RectangleShape, scale::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_setScale), Void, (Ptr{Void}, Vector2f,), shape.ptr, scale)
end

function set_origin(shape::RectangleShape, origin::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_setOrigin), Void, (Ptr{Void}, Vector2f,), shape.ptr, origin)
end

function set_texture(shape::RectangleShape, texture::Texture)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_setTexture), Void, (Ptr{Void}, Ptr{Void}), shape.ptr, texture.ptr)
end

function set_size(shape::RectangleShape, size::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_setSize), Void, (Ptr{Void}, Vector2f,), shape.ptr, size)
end

function set_fillcolor(shape::RectangleShape, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_setFillColor), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function set_outlinecolor(shape::RectangleShape, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_setOutlineColor), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function set_outline_thickness(shape::RectangleShape, thickness::Real)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_setOutlineThickness), Void, (Ptr{Void}, Cfloat,), shape.ptr, thickness)
end

function get_position(shape::RectangleShape)
	return ccall(dlsym(libcsfml_graphics, :sfRectangleShape_getPosition), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_scale(shape::RectangleShape)
	return ccall(dlsym(libcsfml_graphics, :sfRectangleShape_getScale), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_size(shape::RectangleShape)
	return ccall(dlsym(libcsfml_graphics, :sfRectangleShape_getSize), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_fillcolor(shape::RectangleShape)
	return ccall(dlsym(libcsfml_graphics, :sfRectangleShape_getFillColor), Color, (Ptr{Void},), shape.ptr)
end

function get_outlinecolor(shape::RectangleShape)
	return ccall(dlsym(libcsfml_graphics, :sfRectangleShape_getOutlineColor), Color, (Ptr{Void},), shape.ptr)
end

function get_outline_thickness(shape::RectangleShape)
	return Real(ccall(dlsym(libcsfml_graphics, :sfRectangleShape_getOutlineThickness), Cfloat, (Ptr{Void},), shape.ptr))
end

function move(shape::RectangleShape, offset::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_move), Void, (Ptr{Void}, Vector2f,), shape.ptr, offset)
end

function rotate(shape::RectangleShape, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_rotate), Void, (Ptr{Void}, Cfloat,), shape.ptr, angle)
end

function scale(shape::RectangleShape, factors::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfRectangleShape_scale), Void, (Ptr{Void}, Vector2f,), shape.ptr, factors)
end

function get_localbounds(shape::RectangleShape)
	return ccall(dlsym(libcsfml_graphics, :sfRectangleShape_getLocalBounds), FloatRect, (Ptr{Void},), shape.ptr)
end

function get_globalbounds(shape::RectangleShape)
	return ccall(dlsym(libcsfml_graphics, :sfRectangleShape_getGlobalBounds), FloatRect, (Ptr{Void},), shape.ptr)
end

export RectangleShape, set_position, set_size, set_fillcolor, set_outlinecolor, move, set_origin, set_origin, get_fillcolor, get_outlinecolor, get_size, get_position, set_texture, set_scale, scale, rotate, set_rotation, copy, get_localbounds, get_globalbounds, set_outline_thickness, get_outline_thickness
