type RenderText
	ptr::Ptr{Void}

	function RenderText(ptr::Ptr{Void})
		t = new(ptr)
		# finalizer(t, destroy)
		# t
	end
end

function RenderText()
	r = RenderText(ccall(dlsym(libcsfml_graphics, :sfText_create), Ptr{Void}, ()))
	set_font(r, Font("$(Pkg.dir("SFML"))/assets/arial.ttf"))
	r
end

function copy(text::RenderText)
	return RenderText(ccall(dlsym(libcsfml_graphics, :sfText_copy), Ptr{Void}, (Ptr{Void},), text.ptr))
end

function destroy(text::RenderText)
	ccall(dlsym(libcsfml_graphics, :sfText_destroy), Void, (Ptr{Void},), text.ptr)
end

function set_position(text::RenderText, pos::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfText_setPosition), Void, (Ptr{Void}, Vector2f,), text.ptr, pos)
end

function set_rotation(text::RenderText, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfText_setRotation), Void, (Ptr{Void}, Cfloat,), text.ptr, angle)
end

function set_scale(text::RenderText, scale::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfText_setScale), Void, (Ptr{Void}, Vector2f), text.ptr, scale)
end

function set_origin(text::RenderText, origin::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfText_setOrigin), Void, (Ptr{Void}, Vector2f,), text.ptr, origin)
end

function get_position(text::RenderText)
	return ccall(dlsym(libcsfml_graphics, :sfText_getPosition), Vector2f, (Ptr{Void},), text.ptr)
end

function get_rotation(text::RenderText)
	return Real(ccall(dlsym(libcsfml_graphics, :sfText_getRotation), Cfloat, (Ptr{Void},), text.ptr))
end

function get_scale(text::RenderText)
	return ccall(dlsym(libcsfml_graphics, :sfText_getScale), Vector2f, (Ptr{Void},), text.ptr)
end

function get_origin(text::RenderText)
	return ccall(dlsym(libcsfml_graphics, :sfText_getOrigin), Vector2f, (Ptr{Void},), text.ptr)
end

function move(text::RenderText, offsets::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfText_move), Void, (Ptr{Void}, Vector2f,), text.ptr, offsets)
end

function rotate(text::RenderText, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfText_rotate), Void, (Ptr{Void}, Cfloat,), text.ptr, angle)
end

function scale(text::RenderText, factors::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfText_scale), Void, (Ptr{Void}, Vector2f,), text.ptr, factors)
end

function set_string(text::RenderText, string::String)
	ccall(dlsym(libcsfml_graphics, :sfText_setString), Void, (Ptr{Void}, Ptr{Cchar},), text.ptr, pointer(string))
end

function set_font(text::RenderText, font::Font)
	ccall(dlsym(libcsfml_graphics, :sfText_setFont), Void, (Ptr{Void}, Ptr{Void},), text.ptr, font.ptr)
end

function set_charactersize(text::RenderText, size::Int)
	ccall(dlsym(libcsfml_graphics, :sfText_setCharacterSize), Void, (Ptr{Void}, Uint32,), text.ptr, size)
end

function set_style(text::RenderText, style::Int)
	ccall(dlsym(libcsfml_graphics, :sfText_setStyle), Void, (Ptr{Void}, Uint32,), text.ptr, style)
end

function set_color(text::RenderText, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfText_setColor), Void, (Ptr{Void}, Color,), text.ptr, color)
end

function get_string(text::RenderText)
	return bytestring(ccall(dlsym(libcsfml_graphics, :sfText_getString), Ptr{Cchar}, (Ptr{Void},), text.ptr))
end

function get_font(text::RenderText)
	return Font(ccall(dlsym(libcsfml_graphics, :sfText_getFont), Ptr{Void}, (Ptr{Void},), text.ptr))
end

function get_charactersize(text::RenderText)
	return Int(ccall(dlsym(libcsfml_graphics, :sfText_getCharacterSize), Uint32, (Ptr{Void},), text.ptr))
end

function get_style(text::RenderText)
	return Int(ccall(dlsym(libcsfml_graphics, :sfText_getStyle), Uint32, (Ptr{Void},), text.ptr))
end

function get_color(text::RenderText)
	return ccall(dlsym(libcsfml_graphics, :sfText_getColor), Color, (Ptr{Void},), text.ptr)
end

function get_localbounds(text::RenderText)
	return ccall(dlsym(libcsfml_graphics, :sfText_getLocalBounds), FloatRect, (Ptr{Void},), text.ptr)
end

function get_globalbounds(text::RenderText)
	ccall(dlsym(libcsfml_graphics, :sfText_getGlobalBounds), FloatRect, (Ptr{Void},), text.ptr)
end

export set_color, set_style, set_charactersize, set_font, set_string, scale, rotate, move, get_origin,
get_scale, get_rotation, get_position, set_origin, set_scale, set_rotation, set_position, copy,
RenderText, get_localbounds, get_globalbounds, get_style, get_string, get_font, get_charactersize, get_color
