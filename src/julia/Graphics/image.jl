type Image
	ptr::Ptr{Void}
end

function save_to_file(image::Image, filename::ASCIIString)
	return ccall((:sfImage_saveToFile, "libcsfml-graphics"), Int32, (Ptr{Void}, Ptr{Cchar},), image.ptr, pointer(filename)) == 1
end

export Image, save_to_file
