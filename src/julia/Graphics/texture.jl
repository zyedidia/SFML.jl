type Texture
	ptr::Ptr{Void}
end

function Texture(filename::ASCIIString)
	return Texture(ccall((:sfTexture_createFromFile, "libcsfml-graphics"), Ptr{Void}, (Ptr{Cchar}, Ptr{Void},), pointer(filename), C_NULL))
end

export Texture
