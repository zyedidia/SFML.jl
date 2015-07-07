type Image
    ptr::Ptr{Void}

    function Image(ptr::Ptr{Void})
        i = new(ptr)
        finalizer(i, destroy)
        i
    end
end

function Image(filename::String)
    Image(ccall((:sfImage_createFromFile, "libcsfml-graphics"), Ptr{Void}, (Ptr{Cchar},), filename))
end

function Image(width::Integer, height::Integer, color::Color = SFML.black)
    Image(ccall((:sfImage_createFromColor, "libcsfml-graphics"), Ptr{Void}, (Uint32, Uint32, Color,), width, height, color))
end

function copy(image::Image)
    Image(ccall((:sfImage_copy, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), image.ptr))
end

function destroy(image::Image)
    ccall((:sfImage_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), image.ptr)
end

function save_to_file(image::Image, filename::String)
    ccall((:sfImage_saveToFile, "libcsfml-graphics"), Bool, (Ptr{Void}, Ptr{Cchar},), image.ptr, filename)
end

function set_pixel(image::Image, x::Integer, y::Integer, color::Color)
    ccall((:sfImage_setPixel, "libcsfml-graphics"), Void, (Ptr{Void}, Uint32, Uint32, Color,), image.ptr, x, y, color)
end

function get_pixel(image::Image, x::Integer, y::Integer)
    ccall((:sfImage_getPixel, "libcsfml-graphics"), Color, (Ptr{Void}, Uint32, Uint32,), image.ptr, x, y)
end

function get_pixels(image::Image)
    imgsize = get_size(image)
    pointer_to_array(ccall((:sfImage_getPixelsPtr, "libcsfml-graphics"), Ptr{Uint8}, (Ptr{Void},), image.ptr), imgsize.x * imgsize.y)
end

function get_size(image::Image)
    ccall((:sfImage_getSize, "libcsfml-graphics"), Vector2u, (Ptr{Void},), image.ptr)
end

function flip_horizontally(image::Image)
    ccall((:sfImage_flipHorizontally, "libcsfml-graphics"), Void, (Ptr{Void},), image.ptr)
end

function flip_vertically(image::Image)
    ccall((:sfImage_flipVertically, "libcsfml-graphics"), Void, (Ptr{Void},), image.ptr)
end
