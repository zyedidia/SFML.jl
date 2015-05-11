type ConvexShape
	ptr::Ptr{Void}
	_texture::Texture

	function ConvexShape(ptr::Ptr{Void})
		c = new(ptr)
		finalizer(c, destroy)
		c
	end
end

function ConvexShape()
	ConvexShape(ccall(dlsym(libcsfml_graphics, :sfConvexShape_create), Ptr{Void}, ()))
end

function copy(shape::ConvexShape)
	return ConvexShape(ccall(dlsym(libcsfml_graphics, :sfConvexShape_copy), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function destroy(shape::ConvexShape)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_destroy), Void, (Ptr{Void},), shape.ptr)
end

function set_position(shape::ConvexShape, pos::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_setPosition), Void, (Ptr{Void}, Vector2f,), shape.ptr, pos)
end

function set_rotation(shape::ConvexShape, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_setRotation), Void, (Ptr{Void}, Cfloat,), shape.ptr, angle)
end

function set_scale(shape::ConvexShape, scale::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_setScale), Void, (Ptr{Void}, Vector2f,), shape.ptr, scale)
end

function set_origin(shape::ConvexShape, origin::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_setOrigin), Void, (Ptr{Void}, Vector2f,), shape.ptr, origin)
end

function get_position(shape::ConvexShape)
	return ccall(dlsym(libcsfml_graphics, :sfConvexShape_getPosition), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_rotation(shape::ConvexShape)
	return Real(ccall(dlsym(libcsfml_graphics, :sfConvexShape_getRotation), Cfloat, (Ptr{Void},), shape.ptr))
end

function get_scale(shape::ConvexShape)
	return ccall(dlsym(libcsfml_graphics, :sfConvexShape_getScale), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_origin(shape::ConvexShape)
	return ccall(dlsym(libcsfml_graphics, :sfConvexShape_getOrigin), Vector2f, (Ptr{Void},), shape.ptr)
end

function move(shape::ConvexShape, offset::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_move), Void, (Ptr{Void}, Vector2f), shape.ptr, offset)
end

function rotate(shape::ConvexShape, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_rotate), Void, (Ptr{Void}, Cfloat,), shape.ptr, angle)
end

function scale(shape::ConvexShape, factors::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_scale), Void, (Ptr{Void}, Vector2f,), shape.ptr, factors)
end

function set_texture(shape::ConvexShape, texture::Texture)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_setTexture), Void, (Ptr{Void}, Ptr{Void},), shape.ptr, texture.ptr)
	shape._texture = texture
end

function set_texture_rect(shape::ConvexShape, rect::IntRect)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_setTextureRect), Void, (Ptr{Void}, IntRect,), shape.ptr, rect)
end

function set_fillcolor(shape::ConvexShape, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_setFillColor), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function set_outlinecolor(shape::ConvexShape, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_setOutlineColor), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function set_outline_thickness(shape::ConvexShape, thickness::Real)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_setOutlineThickness), Void, (Ptr{Void}, Cfloat,), shape.ptr, thickness)
end

function get_texture(shape::ConvexShape)
	return Texture(ccall(dlsym(libcsfml_graphics, :sfConvexShape_getTexture), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function get_texture_rect(shape::ConvexShape)
	return ccall(dlsym(libcsfml_graphics, :sfConvexShape_getTextureRect), IntRect, (Ptr{Void},), shape.ptr)
end

function get_fillcolor(shape::ConvexShape)
	return ccall(dlsym(libcsfml_graphics, :sfConvexShape_getFillColor), Color, (Ptr{Void},), shape.ptr)
end

function get_outlinecolor(shape::ConvexShape)
	return ccall(dlsym(libcsfml_graphics, :sfConvexShape_getOutlineColor), Color, (Ptr{Void},), shape.ptr)
end

function get_outline_thickness(shape::ConvexShape)
	return Real(ccall(dlsym(libcsfml_graphics, :sfConvexShape_getOutlineThickness), Cfloat, (Ptr{Void},), shape.ptr))
end

function get_pointcount(shape::ConvexShape)
	return Int(ccall(dlsym(libcsfml_graphics, :sfConvexShape_getPointCount), Uint32, (Ptr{Void},), shape.ptr))
end

function get_point(shape::ConvexShape, index::Integer)
	return ccall(dlsym(libcsfml_graphics, :sfConvexShape_getPoint), Vector2f, (Ptr{Void}, Uint32,), shape.ptr, index)
end

function set_pointcount(shape::ConvexShape, count::Integer)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_setPointCount), Void, (Ptr{Void}, Uint32,), shape.ptr, count)
end

function set_point(shape::ConvexShape, index::Integer, point::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfConvexShape_setPoint), Void, (Ptr{Void}, Uint32, Vector2f,), shape.ptr, index, point)
end

function get_localbounds(shape::ConvexShape)
	return ccall(dlsym(libcsfml_graphics, :sfConvexShape_getLocalBounds), FloatRect, (Ptr{Void},), shape.ptr)
end

function get_globalbounds(shape::ConvexShape)
	return ccall(dlsym(libcsfml_graphics, :sfConvexShape_getGlobalBounds), FloatRect, (Ptr{Void},), shape.ptr)
end

export get_globalbounds, get_localbounds, set_point, set_pointcount, get_outline_thickness, get_outlinecolor, 
get_fillcolor, get_texture_rect, get_texture, set_outlinecolor, set_fillcolor, set_position, get_position, set_rotation,
get_rotation, set_scale, get_scale, move, scale, rotate, set_texture_rect, set_texture, set_origin, get_origin,
copy, ConvexShape, get_point, get_pointcount
