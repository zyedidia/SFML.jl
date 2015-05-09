type Font
	ptr::Ptr{Void}

	function Font(ptr::Ptr{Void})
		f = new(ptr)
		finalizer(f, destroy)
		f
	end
end

function Font(filename::String)
	Font(ccall(dlsym(libcsfml_graphics, :sfFont_createFromFile), Ptr{Void}, (Ptr{Cchar},), pointer(filename)))
end

function copy(font::Font)
	return Font(ccall(dlsym(libcsfml_graphics, :sfFont_createFromFile), Ptr{Void}, (Ptr{Void},), font.ptr))
end

function destroy(font::Font)
	ccall(dlsym(libcsfml_graphics, :sfFont_destroy), Void, (Ptr{Void},), font.ptr)
end

export Font, copy
