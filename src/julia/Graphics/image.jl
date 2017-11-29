type Image
    ptr::Ptr{Void}

    function Image(ptr::Ptr{Void})
        i = new(ptr)
        finalizer(i, destroy)
        i
    end
end

function Image(filename::AbstractString)
    Image(ccall((:sfImage_createFromFile, libcsfml_graphics), Ptr{Void}, (Ptr{Cchar},), filename))
end

function Image(width::Integer, height::Integer, color::Color = SFML.black)
    Image(ccall((:sfImage_createFromColor, libcsfml_graphics), Ptr{Void}, (UInt32, UInt32, Color,), width, height, color))
end

function copy(image::Image)
    Image(ccall((:sfImage_copy, libcsfml_graphics), Ptr{Void}, (Ptr{Void},), image.ptr))
end

function destroy(image::Image)
    ccall((:sfImage_destroy, libcsfml_graphics), Void, (Ptr{Void},), image.ptr)
end

function save_to_file(image::Image, filename::AbstractString)
    ccall((:sfImage_saveToFile, libcsfml_graphics), Bool, (Ptr{Void}, Ptr{Cchar},), image.ptr, filename)
end

function set_pixel(image::Image, x::Integer, y::Integer, color::Color)
    ccall((:sfImage_setPixel, libcsfml_graphics), Void, (Ptr{Void}, UInt32, UInt32, Color,), image.ptr, x, y, color)
end

function get_pixel(image::Image, x::Integer, y::Integer)
    ccall((:sfImage_getPixel, libcsfml_graphics), Color, (Ptr{Void}, UInt32, UInt32,), image.ptr, x, y)
end

function get_pixels(image::Image)
    imgsize = get_size(image)
    ptr = ccall((:sfImage_getPixelsPtr, libcsfml_graphics), Ptr{UInt8}, (Ptr{Void},), image.ptr)
    # @compat unsafe_wrap(Vector{UInt8}, ptr, imgsize.x * imgsize.y)
    convert(Array{UInt8}, unsafe_string(ptr, imgsize.x * imgsize.y))
end

function get_size(image::Image)
    ccall((:sfImage_getSize, libcsfml_graphics), Vector2u, (Ptr{Void},), image.ptr)
end

function flip_horizontally(image::Image)
    ccall((:sfImage_flipHorizontally, libcsfml_graphics), Void, (Ptr{Void},), image.ptr)
end

function flip_vertically(image::Image)
    ccall((:sfImage_flipVertically, libcsfml_graphics), Void, (Ptr{Void},), image.ptr)
end
