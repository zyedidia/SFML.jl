type Font
	ptr::Ptr{Void}
end

function Font(filename::String)
	return Font(ccall(dlsym(libcsfml_graphics, :sfFont_createFromFile), Ptr{Void}, (Ptr{Cchar},), pointer(filename)))
end

export Font
