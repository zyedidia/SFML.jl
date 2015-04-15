type Image
	ptr::Ptr{Void}
end

function save_to_file(image::Image, filename::String)
	return ccall(dlsym(libcsfml_graphics, :sfImage_saveToFile), Int32, (Ptr{Void}, Ptr{Cchar},), image.ptr, pointer(filename)) == 1
end

function destroy(image::Image)
	ccall(dlsym(libcsfml_graphics, :sfImage_destroy), Void, (Ptr{Void},), image.ptr)
	image = nothing
end

function get_size(image::Image)
	return ccall(dlsym(libcsfml_graphics, :sfImage_getSize), Vector2u, (Ptr{Void},), image.ptr)
end

export Image, save_to_file, destroy, get_size
