type Font
    ptr::Ptr{Void}

    function Font(ptr::Ptr{Void})
        f = new(ptr)
        finalizer(f, destroy)
        f
    end
end

function Font(filename::AbstractString)
    Font(ccall((:sfFont_createFromFile, libcsfml_graphics), Ptr{Void}, (Ptr{Cchar},), filename))
end

function copy(font::Font)
    Font(ccall((:sfFont_createFromFile, libcsfml_graphics), Ptr{Void}, (Ptr{Void},), font.ptr))
end

function destroy(font::Font)
    ccall((:sfFont_destroy, libcsfml_graphics), Void, (Ptr{Void},), font.ptr)
end
