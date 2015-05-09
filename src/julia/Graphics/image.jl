type Image
	ptr::Ptr{Void}

	function Image(ptr::Ptr{Void})
		i = new(ptr)
		finalizer(i, destroy)
		i
	end
end

function Image(filename::String)
	Image(ccall(dlsym(libcsfml_graphics, :sfImage_createFromFile), Ptr{Void}, (Ptr{Cchar},), pointer(filename)))
end

function Image(width::Integer, height::Integer, color::Color = SFML.black)
	Image(ccall(dlsym(libcsfml_graphics, :sfImage_create), Ptr{Void}, (Uint32, Uint32, Color,), width, height, color))
end

function copy(image::Image)
	return Image(ccall(dlsym(libcsfml_graphics, :sfImage_copy), Ptr{Void}, (Ptr{Void},), image.ptr))
end

function destroy(image::Image)
	ccall(dlsym(libcsfml_graphics, :sfImage_destroy), Void, (Ptr{Void},), image.ptr)
end

function save_to_file(image::Image, filename::String)
	return ccall(dlsym(libcsfml_graphics, :sfImage_saveToFile), Int32, (Ptr{Void}, Ptr{Cchar},), image.ptr, pointer(filename)) == 1
end

function set_pixel(image::Image, x::Integer, y::Integer, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfImage_setPixel), Void, (Ptr{Void}, Uint32, Uint32, Color,), image.ptr, x, y, color)
end

function get_pixel(image::Image, x::Integer, y::Integer)
	return ccall(dlsym(libcsfml_graphics, :sfImage_getPixel), Color, (Ptr{Void}, Uint32, Uint32,), image.ptr, x, y)
end

function get_pixels(image::Image)
	imgsize = get_size(image)
	return pointer_to_array(ccall(dlsym(libcsfml_graphics, :sfImage_getPixelsPtr), Ptr{Uint8}, (Ptr{Void},), image.ptr), imgsize.x * imgsize.y)
end

function get_size(image::Image)
	return ccall(dlsym(libcsfml_graphics, :sfImage_getSize), Vector2u, (Ptr{Void},), image.ptr)
end

function flip_horizontally(image::Image)
	ccall(dlsym(libcsfml_graphics, :sfImage_flipHorizontally), Void, (Ptr{Void},), image.ptr)
end

function flip_vertically(image::Image)
	ccall(dlsym(libcsfml_graphics, :sfImage_flipVertically), Void, (Ptr{Void},), image.ptr)
end

export Image, save_to_file, get_size, set_pixel, get_pixel, get_pixels,
flip_vertically, flip_horizontally, copy
