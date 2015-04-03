type Text
	ptr::Ptr{Void}
end

function Text()
	return Text(ccall((:sfText_create, "libcsfml-graphics"), Ptr{Void}, ()))
end

function copy(text::Text)
	return Text(ccall((:sfText_copy, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), text.ptr))
end

function destroy(text::Text)
	ccall((:sfText_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), text.ptr)
	text = nothing
end

function set_position(text::Text, pos::Vector2f)
	ccall((:sfText_setPosition, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), text.ptr, pos)
end

function set_rotation(text::Text, angle::Real)
	ccall((:sfText_setRotation, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), text.ptr, angle)
end

function set_scale(text::Text, scale::Vector2f)
	ccall((:sfText_setScale, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f), text.ptr, scale)
end

function set_origin(text::Text, origin::Vector2f)
	ccall((:sfText_setOrigin, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), text.ptr, origin)
end

function get_position(text::Text)
	return ccall((:sfText_getPosition, "libcsfml-graphics"), Vector2f, (Ptr{Void},), text.ptr)
end

function get_rotation(text::Text)
	return Real(ccall((:sfText_getRotation, "libcsfml-graphics"), Cfloat, (Ptr{Void},), text.ptr))
end

function get_scale(text::Text)
	return ccall((:sfText_getScale, "libcsfml-graphics"), Vector2f, (Ptr{Void},), text.ptr)
end

function get_origin(text::Text)
	return ccall((:sfText_getOrigin, "libcsfml-graphics"), Vector2f, (Ptr{Void},), text.ptr)
end

function move(text::Text, offsets::Vector2f)
	ccall((:sfText_move, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), text.ptr, offsets)
end

function rotate(text::Text, angle::Real)
	ccall((:sfText_rotate, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), text.ptr, angle)
end

function scale(text::Text, factors::Vector2f)
	ccall((:sfText_scale, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), text.ptr, factors)
end

function set_string(text::Text, string::ASCIIString)
	ccall((:sfText_setString, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Cchar},), text.ptr, pointer(string))
end

function set_font(text::Text, font::Font)
	ccall((:sfText_setFont, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void},), text.ptr, font.ptr)
end

function set_charactersize(text::Text, size::Int)
	ccall((:sfText_setCharacterSize, "libcsfml-graphics"), Void, (Ptr{Void}, Uint32,), text.ptr, size)
end

function set_style(text::Text, style::Int)
	ccall((:sfText_setStyle, "libcsfml-graphics"), Void, (Ptr{Void}, Uint32,), text.ptr, style)
end

function set_color(text::Text, color::Color)
	ccall((:sfText_setColor, "libcsfml-graphics"), Void, (Ptr{Void}, Color,), text.ptr, color)
end

function get_localbounds(text::Text)
	return ccall((:sfText_getLocalBounds, "libcsfml-graphics"), FloatRect, (Ptr{Void},), text.ptr)
end

function get_globalbounds(text::Text)
	return ccall((:sfText_getGlobalBounds, "libcsfml-graphics"), FloatRect, (Ptr{Void},), text.ptr)
end

export set_color, set_style, set_charactersize, set_font, set_string, scale, rotate, move, get_origin, get_scale, get_rotation, get_position, set_origin, set_scale, set_rotation, set_position, destroy, copy, Text
