type Font
	ptr::Ptr{Void}
end

function Font(filename::ASCIIString)
	return Font(ccall((:sfFont_createFromFile, "libcsfml-graphics"), Ptr{Void}, (Ptr{Cchar},), pointer(filename)))
end

export Font
