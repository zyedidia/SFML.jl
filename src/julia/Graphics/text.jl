type RenderText <: Drawable
	ptr::Ptr{Void}
	_font::Font

	function RenderText(ptr::Ptr{Void})
		t = new(ptr)
		finalizer(t, destroy)
		t
	end
end

function RenderText()
	r = RenderText(ccall((:sfText_create, "libcsfml-graphics"), Ptr{Void}, ()))
	set_font(r, Font("$(Pkg.dir("SFML"))/assets/arial.ttf"))
	r
end

function copy(text::RenderText)
	return RenderText(ccall((:sfText_copy, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), text.ptr))
end

function destroy(text::RenderText)
	ccall((:sfText_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), text.ptr)
end

function set_position(text::RenderText, pos::Vector2f)
	ccall((:sfText_setPosition, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), text.ptr, pos)
end

function set_rotation(text::RenderText, angle::Real)
	ccall((:sfText_setRotation, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), text.ptr, angle)
end

function set_scale(text::RenderText, scale::Vector2f)
	ccall((:sfText_setScale, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f), text.ptr, scale)
end

function set_origin(text::RenderText, origin::Vector2f)
	ccall((:sfText_setOrigin, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), text.ptr, origin)
end

function get_position(text::RenderText)
	return ccall((:sfText_getPosition, "libcsfml-graphics"), Vector2f, (Ptr{Void},), text.ptr)
end

function get_rotation(text::RenderText)
	return Real(ccall((:sfText_getRotation, "libcsfml-graphics"), Cfloat, (Ptr{Void},), text.ptr))
end

function get_scale(text::RenderText)
	return ccall((:sfText_getScale, "libcsfml-graphics"), Vector2f, (Ptr{Void},), text.ptr)
end

function get_origin(text::RenderText)
	return ccall((:sfText_getOrigin, "libcsfml-graphics"), Vector2f, (Ptr{Void},), text.ptr)
end

function move(text::RenderText, offsets::Vector2f)
	ccall((:sfText_move, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), text.ptr, offsets)
end

function rotate(text::RenderText, angle::Real)
	ccall((:sfText_rotate, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), text.ptr, angle)
end

function scale(text::RenderText, factors::Vector2f)
	ccall((:sfText_scale, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), text.ptr, factors)
end

function set_string(text::RenderText, string::String)
	ccall((:sfText_setString, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Cchar},), text.ptr, string)
end

function set_font(text::RenderText, font::Font)
	ccall((:sfText_setFont, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void},), text.ptr, font.ptr)
	text._font = font
end

function set_charactersize(text::RenderText, size::Int)
	ccall((:sfText_setCharacterSize, "libcsfml-graphics"), Void, (Ptr{Void}, Uint32,), text.ptr, size)
end

function set_style(text::RenderText, style::Int)
	ccall((:sfText_setStyle, "libcsfml-graphics"), Void, (Ptr{Void}, Uint32,), text.ptr, style)
end

function set_color(text::RenderText, color::Color)
	ccall((:sfText_setColor, "libcsfml-graphics"), Void, (Ptr{Void}, Color,), text.ptr, color)
end

function get_string(text::RenderText)
	return bytestring(ccall((:sfText_getString, "libcsfml-graphics"), Ptr{Cchar}, (Ptr{Void},), text.ptr))
end

function get_font(text::RenderText)
	return Font(ccall((:sfText_getFont, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), text.ptr))
end

function get_charactersize(text::RenderText)
	return Int(ccall((:sfText_getCharacterSize, "libcsfml-graphics"), Uint32, (Ptr{Void},), text.ptr))
end

function get_style(text::RenderText)
	return Int(ccall((:sfText_getStyle, "libcsfml-graphics"), Uint32, (Ptr{Void},), text.ptr))
end

function get_color(text::RenderText)
	return ccall((:sfText_getColor, "libcsfml-graphics"), Color, (Ptr{Void},), text.ptr)
end

function get_localbounds(text::RenderText)
	return ccall((:sfText_getLocalBounds, "libcsfml-graphics"), FloatRect, (Ptr{Void},), text.ptr)
end

function get_globalbounds(text::RenderText)
	ccall((:sfText_getGlobalBounds, "libcsfml-graphics"), FloatRect, (Ptr{Void},), text.ptr)
end

export set_color, set_style, set_charactersize, set_font, set_string, scale, rotate, move, get_origin,
get_scale, get_rotation, get_position, set_origin, set_scale, set_rotation, set_position, copy,
RenderText, get_localbounds, get_globalbounds, get_style, get_string, get_font, get_charactersize, get_color
