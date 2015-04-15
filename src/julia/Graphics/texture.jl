type Texture
	ptr::Ptr{Void}
end

function Texture(filename::String)
	return Texture(ccall(dlsym(libcsfml_graphics, :sfTexture_createFromFile), Ptr{Void}, (Ptr{Cchar}, Ptr{Void},), pointer(filename), C_NULL))
end

function Texture(image::Image)
	return Texture(ccall(dlsym(libcsfml_graphics, :sfTexture_createFromImage), Ptr{Void}, (Ptr{Void}, Ptr{Void},), image.ptr, C_NULL))
end

function copy(texture::Texture)
	return Texture(ccall(dlsym(libcsfml_graphics, :sfTexture_copy), Ptr{Void}, (Ptr{Void},), texture.ptr))
end

function destroy(texture::Texture)
	ccall(dlsym(libcsfml_graphics, :sfTexture_destroy), Void, (Ptr{Void},), texture.ptr)
end

function get_size(texture::Texture)
	return ccall(dlsym(libcsfml_graphics, :sfTexture_getSize), Vector2u, (Ptr{Void},), texture.ptr)
end

function copy_to_image(texture::Texture)
	return Image(ccall(dlsym(libcsfml_graphics, :sfTexture_copyToImage), Ptr{Void}, (Ptr{Void},), texture.ptr))
end

function set_smooth(texture::Texture, smooth::Bool)
	ccall(dlsym(libcsfml_graphics, :sfTexture_setSmooth), Void, (Ptr{Void}, Int32,), texture.ptr, smooth)
end

function is_smooth(texture::Texture)
	return Bool(ccall(dlsym(libcsfml_graphics, :sfTexture_isSmooth), Int32, (Ptr{Void},), texture.ptr))
end

export Texture, copy, destroy, get_size, copy_to_image, set_smooth, is_smooth
