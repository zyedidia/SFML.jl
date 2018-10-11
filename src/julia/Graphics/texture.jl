mutable struct Texture
    ptr::Ptr{Nothing}

    function Texture(ptr::Ptr{Nothing})
        t = new(ptr)
        # finalizer(t, destroy)
        # t
    end
end

Texture() = Texture(C_NULL)
function Texture(width::Integer, height::Integer)
    Texture(ccall((:sfTexture_create, libcsfml_graphics), Ptr{Nothing}, (UInt32, UInt32,), width, height))
end

function Texture(filename::AbstractString)
    Texture(ccall((:sfTexture_createFromFile, libcsfml_graphics), Ptr{Nothing}, (Ptr{Cchar}, Ptr{Nothing},), filename, C_NULL))
end

function Texture(image::Image)
    Texture(ccall((:sfTexture_createFromImage, libcsfml_graphics), Ptr{Nothing}, (Ptr{Nothing}, Ptr{Nothing},), image.ptr, C_NULL))
end

function copy(texture::Texture)
    return Texture(ccall((:sfTexture_copy, libcsfml_graphics), Ptr{Nothing}, (Ptr{Nothing},), texture.ptr))
end

function destroy(texture::Texture)
    # println("Destroy $(texture.ptr)")
    ccall((:sfTexture_destroy, libcsfml_graphics), Nothing, (Ptr{Nothing},), texture.ptr)
end

function get_size(texture::Texture)
    return ccall((:sfTexture_getSize, libcsfml_graphics), Vector2u, (Ptr{Nothing},), texture.ptr)
end

function copy_to_image(texture::Texture)
    return Image(ccall((:sfTexture_copyToImage, libcsfml_graphics), Ptr{Nothing}, (Ptr{Nothing},), texture.ptr))
end

function update(texture::Texture, window::RenderWindow, width::Integer=0, height::Integer=0)
    ccall((:sfTexture_updateFromWindow, libcsfml_graphics), Nothing, (Ptr{Nothing}, Ptr{Nothing}, UInt32, UInt32,), texture.ptr, window.ptr, width, height)
end

function update(texture::Texture, image::Image, x_off::Integer=0, y_off::Integer=0)
    ccall((:sfTexture_updateFromImage, libcsfml_graphics), Nothing, (Ptr{Nothing}, Ptr{Nothing}, UInt32, UInt32,), texture.ptr, image.ptr, x_off, y_off)
end

function set_smooth(texture::Texture, smooth::Bool)
    ccall((:sfTexture_setSmooth, libcsfml_graphics), Nothing, (Ptr{Nothing}, Int32,), texture.ptr, smooth)
end

function is_smooth(texture::Texture)
    ccall((:sfTexture_isSmooth, libcsfml_graphics), Bool, (Ptr{Nothing},), texture.ptr)
end

function set_repeated(texture::Texture, repeated::Bool)
    ccall((:sfTexture_setRepeated, libcsfml_graphics), Nothing, (Ptr{Nothing}, Int32), texture.ptr, repeated)
end

function is_repeated(texture::Texture)
    ccall((:sfTexture_isRepeated, libcsfml_graphics), Bool, (Ptr{Nothing},), texture.ptr)
end
