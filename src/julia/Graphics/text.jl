type Text
	ptr::Ptr{Void}
end

function Text()
	return Text(ccall(dlsym(libcsfml_graphics, :sfText_create), Ptr{Void}, ()))
end

function copy(text::Text)
	return Text(ccall(dlsym(libcsfml_graphics, :sfText_copy), Ptr{Void}, (Ptr{Void},), text.ptr))
end

function destroy(text::Text)
	ccall(dlsym(libcsfml_graphics, :sfText_destroy), Void, (Ptr{Void},), text.ptr)
	text = nothing
end

function set_position(text::Text, pos::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfText_setPosition), Void, (Ptr{Void}, Vector2f,), text.ptr, pos)
end

function set_rotation(text::Text, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfText_setRotation), Void, (Ptr{Void}, Cfloat,), text.ptr, angle)
end

function set_scale(text::Text, scale::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfText_setScale), Void, (Ptr{Void}, Vector2f), text.ptr, scale)
end

function set_origin(text::Text, origin::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfText_setOrigin), Void, (Ptr{Void}, Vector2f,), text.ptr, origin)
end

function get_position(text::Text)
	return ccall(dlsym(libcsfml_graphics, :sfText_getPosition), Vector2f, (Ptr{Void},), text.ptr)
end

function get_rotation(text::Text)
	return Real(ccall(dlsym(libcsfml_graphics, :sfText_getRotation), Cfloat, (Ptr{Void},), text.ptr))
end

function get_scale(text::Text)
	return ccall(dlsym(libcsfml_graphics, :sfText_getScale), Vector2f, (Ptr{Void},), text.ptr)
end

function get_origin(text::Text)
	return ccall(dlsym(libcsfml_graphics, :sfText_getOrigin), Vector2f, (Ptr{Void},), text.ptr)
end

function move(text::Text, offsets::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfText_move), Void, (Ptr{Void}, Vector2f,), text.ptr, offsets)
end

function rotate(text::Text, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfText_rotate), Void, (Ptr{Void}, Cfloat,), text.ptr, angle)
end

function scale(text::Text, factors::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfText_scale), Void, (Ptr{Void}, Vector2f,), text.ptr, factors)
end

function set_string(text::Text, string::ASCIIString)
	ccall(dlsym(libcsfml_graphics, :sfText_setString), Void, (Ptr{Void}, Ptr{Cchar},), text.ptr, pointer(string))
end

function set_font(text::Text, font::Font)
	ccall(dlsym(libcsfml_graphics, :sfText_setFont), Void, (Ptr{Void}, Ptr{Void},), text.ptr, font.ptr)
end

function set_charactersize(text::Text, size::Int)
	ccall(dlsym(libcsfml_graphics, :sfText_setCharacterSize), Void, (Ptr{Void}, Uint32,), text.ptr, size)
end

function set_style(text::Text, style::Int)
	ccall(dlsym(libcsfml_graphics, :sfText_setStyle), Void, (Ptr{Void}, Uint32,), text.ptr, style)
end

function set_color(text::Text, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfText_setColor), Void, (Ptr{Void}, Color,), text.ptr, color)
end

function get_localbounds(text::Text)
	return ccall(dlsym(libcsfml_graphics, :sfText_getLocalBounds), FloatRect, (Ptr{Void},), text.ptr)
end

function get_globalbounds(text::Text)
	return ccall(dlsym(libcsfml_graphics, :sfText_getGlobalBounds), FloatRect, (Ptr{Void},), text.ptr)
end

export set_color, set_style, set_charactersize, set_font, set_string, scale, rotate, move, get_origin, get_scale, get_rotation, get_position, set_origin, set_scale, set_rotation, set_position, destroy, copy, Text, get_localbounds, get_globalbounds
