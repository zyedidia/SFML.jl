type VideoMode
	width::Uint32
	height::Uint32
	bits_per_pixel::Uint32

	function VideoMode(width::Int, height::Int, bits_per_pixel::Int)
		return new(width, height, bits_per_pixel)
	end
	
	function VideoMode(width::Int, height::Int)
		return new(width, height, 32)
	end
end

function get_desktop_mode()
	return ccall(dlsym(libcsfml_graphics, :sfVideoMode_getDesktopMode), VideoMode, ())
end

function is_valid(mode::VideoMode)
	return Bool(ccall(dlsym(libcsfml_graphics, :sfVideoMode_isValid), Int32, (VideoMode,), mode))
end

export VideoMode, get_desktop_mode, is_valid
