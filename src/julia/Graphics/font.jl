mutable struct Font
    ptr::Ptr{Nothing}

    function Font(ptr::Ptr{Nothing})
        f = new(ptr)
        finalizer(f, destroy)
        f
    end
end

function Font(filename::AbstractString)
    Font(ccall((:sfFont_createFromFile, libcsfml_graphics), Ptr{Nothing}, (Ptr{Cchar},), filename))
end

function copy(font::Font)
    Font(ccall((:sfFont_createFromFile, libcsfml_graphics), Ptr{Nothing}, (Ptr{Nothing},), font.ptr))
end

function destroy(font::Font)
    ccall((:sfFont_destroy, libcsfml_graphics), Nothing, (Ptr{Nothing},), font.ptr)
end
