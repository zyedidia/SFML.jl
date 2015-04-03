type Texture
	ptr::Ptr{Void}
end

function Texture(filename::ASCIIString)
	return Texture(ccall((:sfTexture_createFromFile, "libcsfml-graphics"), Ptr{Void}, (Ptr{Cchar}, Ptr{Void},), pointer(filename), C_NULL))
end

function Texture(image::Image, area::FloatRect)
	return Texture(ccall((:sfTexture_createFromImage, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void}, FloatRect,), image.ptr, area))
end

function get_size(texture::Texture)
	return ccall((:sfTexture_getSize, "libcsfml-graphics"), Vector2u, (Ptr{Void},), texture.ptr)
end

export Texture
