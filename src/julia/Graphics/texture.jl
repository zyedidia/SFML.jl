type Texture
	ptr::Ptr{Void}
end

function Texture(filename::ASCIIString)
	return Texture(ccall(dlsym(libcsfml_graphics, :sfTexture_createFromFile), Ptr{Void}, (Ptr{Cchar}, Ptr{Void},), pointer(filename), C_NULL))
end

function Texture(image::Image)
	return Texture(ccall(dlsym(libcsfml_graphics, :sfTexture_createFromImage), Ptr{Void}, (Ptr{Void}, Ptr{Void},), image.ptr, C_NULL))
end

function get_size(texture::Texture)
	return ccall(dlsym(libcsfml_graphics, :sfTexture_getSize), Vector2u, (Ptr{Void},), texture.ptr)
end

export Texture
