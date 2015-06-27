type Font
	ptr::Ptr{Void}

	function Font(ptr::Ptr{Void})
		f = new(ptr)
		finalizer(f, destroy)
		f
	end
end

function Font(filename::String)
	Font(ccall((:sfFont_createFromFile, "libcsfml-graphics"), Ptr{Void}, (Ptr{Cchar},), filename))
end

function copy(font::Font)
	Font(ccall((:sfFont_createFromFile, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), font.ptr))
end

function destroy(font::Font)
	ccall((:sfFont_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), font.ptr)
end
