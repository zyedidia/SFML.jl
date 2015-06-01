type VideoMode
	width::Uint32
	height::Uint32
	bits_per_pixel::Uint32

	function VideoMode(width::Integer, height::Integer, bits_per_pixel::Integer)
		return new(width, height, bits_per_pixel)
	end
	
	function VideoMode(width::Integer, height::Integer)
		return new(width, height, 32)
	end
end

function get_desktop_mode()
	return ccall(dlsym(libcsfml_window, :sfVideoMode_getDesktopMode), VideoMode, ())
end

function is_valid(mode::VideoMode)
	return ccall(dlsym(libcsfml_window, :sfVideoMode_isValid), Bool, (VideoMode,), mode)
end

export VideoMode, get_desktop_mode, is_valid
