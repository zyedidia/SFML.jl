mutable struct Sprite <: Drawable
    ptr::Ptr{Nothing}
    _texture::Texture

    function Sprite(ptr::Ptr{Nothing})
        s = new(ptr)
        finalizer(s, destroy)
        s
    end
end

function Sprite()
    Sprite(ccall((:sfSprite_create, libcsfml_graphics), Ptr{Nothing}, ()))
end

function Sprite(texture::Texture)
    s = Sprite()
    set_texture(s, texture)
    s
end

function copy(sprite::Sprite)
    return Sprite(ccall((:sfSprite_copy, libcsfml_graphics), Ptr{Nothing}, (Ptr{Nothing},), sprite.ptr))
end

function destroy(sprite::Sprite)
    ccall((:sfSprite_destroy, libcsfml_graphics), Nothing, (Ptr{Nothing},), sprite.ptr)
end

function set_position(sprite::Sprite, position::Vector2f)
    ccall((:sfSprite_setPosition, libcsfml_graphics), Nothing, (Ptr{Nothing}, Vector2f,), sprite.ptr, position)
end

function set_rotation(sprite::Sprite, angle::Real)
    ccall((:sfSprite_setRotation, libcsfml_graphics), Nothing, (Ptr{Nothing}, Cfloat,), sprite.ptr, angle)
end

function set_scale(sprite::Sprite, scale::Vector2f)
    ccall((:sfSprite_setScale, libcsfml_graphics), Nothing, (Ptr{Nothing}, Vector2f,), sprite.ptr, scale)
end

function set_origin(sprite::Sprite, origin::Vector2f)
    ccall((:sfSprite_setOrigin, libcsfml_graphics), Nothing, (Ptr{Nothing}, Vector2f,), sprite.ptr, origin)
end

function get_position(sprite::Sprite)
    return ccall((:sfSprite_getPosition, libcsfml_graphics), Vector2f, (Ptr{Nothing},), sprite.ptr)
end

function get_rotation(sprite::Sprite)
    return Real(ccall((:sfSprite_getRotation, libcsfml_graphics), Cfloat, (Ptr{Nothing},), sprite.ptr))
end

function get_origin(sprite::Sprite)
    return ccall((:sfSprite_getOrigin, libcsfml_graphics), Vector2f, (Ptr{Nothing},), sprite.ptr)
end

function get_scale(sprite::Sprite)
    ccall((:sfSprite_getScale, libcsfml_graphics), Vector2f, (Ptr{Nothing},), sprite.ptr)
end

function move(sprite::Sprite, offset::Vector2f)
    ccall((:sfSprite_move, libcsfml_graphics), Nothing, (Ptr{Nothing}, Vector2f,), sprite.ptr, offset)
end

function rotate(sprite::Sprite, angle::Real)
    ccall((:sfSprite_rotate, libcsfml_graphics), Nothing, (Ptr{Nothing}, Cfloat,), sprite.ptr, angle)
end

function scale(sprite::Sprite, factors::Vector2f)
    ccall((:sfSprite_scale, libcsfml_graphics), Nothing, (Ptr{Nothing}, Vector2f,), sprite.ptr, factors)
end

function set_texture(sprite::Sprite, texture::Texture)
    sprite._texture = texture
    ccall((:sfSprite_setTexture, libcsfml_graphics), Nothing, (Ptr{Nothing}, Ptr{Nothing}, Int32,), sprite.ptr, texture.ptr, 1)
end

function set_color(sprite::Sprite, color::Color)
    ccall((:sfSprite_setColor, libcsfml_graphics), Nothing, (Ptr{Nothing}, Color,), sprite.ptr, color)
end

function get_texture(sprite::Sprite)
    return Texture(ccall((:sfSprite_getTexture, libcsfml_graphics), Ptr{Nothing}, (Ptr{Nothing},), sprite.ptr))
end

function get_color(sprite::Sprite)
    return ccall((:sfSprite_getColor, libcsfml_graphics), Color, (Ptr{Nothing},), sprite.ptr)
end

function get_localbounds(sprite::Sprite)
    return ccall((:sfSprite_getLocalBounds, libcsfml_graphics), FloatRect, (Ptr{Nothing},), sprite.ptr)
end

function get_globalbounds(sprite::Sprite)
    return ccall((:sfSprite_getGlobalBounds, libcsfml_graphics), FloatRect, (Ptr{Nothing},), sprite.ptr)
end
