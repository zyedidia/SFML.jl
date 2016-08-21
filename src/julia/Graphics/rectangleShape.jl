type RectangleShape <: Drawable
    ptr::Ptr{Void}
    _texture::Texture

    function RectangleShape(ptr::Ptr{Void})
        r = new(ptr)
        finalizer(r, destroy)
        r
    end
end

function RectangleShape()
    RectangleShape(ccall((:sfRectangleShape_create, libcsfml_graphics), Ptr{Void}, ()))
end

function copy(shape::RectangleShape)
    return RectangleShape(ccall((:sfRectangleShape_copy, libcsfml_graphics), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function destroy(shape::RectangleShape)
    ccall((:sfRectangleShape_destroy, libcsfml_graphics), Void, (Ptr{Void},), shape.ptr)
end

function set_position(shape::RectangleShape, position::Vector2f)
    ccall((:sfRectangleShape_setPosition, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), shape.ptr, position)
end

function set_rotation(shape::RectangleShape, angle::Real)
    ccall((:sfRectangleShape_setRotation, libcsfml_graphics), Void, (Ptr{Void}, Cfloat), shape.ptr, angle)
end

function set_scale(shape::RectangleShape, scale::Vector2f)
    ccall((:sfRectangleShape_setScale, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), shape.ptr, scale)
end

function set_origin(shape::RectangleShape, origin::Vector2f)
    ccall((:sfRectangleShape_setOrigin, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), shape.ptr, origin)
end



function set_size(shape::RectangleShape, size::Vector2f)
    ccall((:sfRectangleShape_setSize, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), shape.ptr, size)
end

function set_fillcolor(shape::RectangleShape, color::Color)
    ccall((:sfRectangleShape_setFillColor, libcsfml_graphics), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function set_texture(shape::RectangleShape, texture::Texture)
    ccall((:sfRectangleShape_setTexture, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Void}, Int32,), shape.ptr, texture.ptr, false)
    shape._texture = texture
end

function set_texture_rect(shape::RectangleShape, rect::IntRect)
    ccall((:sfRectangleShape_setTextureRect, libcsfml_graphics), Void, (Ptr{Void}, IntRect,), shape.ptr, rect)
end

function set_outlinecolor(shape::RectangleShape, color::Color)
    ccall((:sfRectangleShape_setOutlineColor, libcsfml_graphics), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function set_outline_thickness(shape::RectangleShape, thickness::Real)
    ccall((:sfRectangleShape_setOutlineThickness, libcsfml_graphics), Void, (Ptr{Void}, Cfloat,), shape.ptr, thickness)
end

function get_position(shape::RectangleShape)
    return ccall((:sfRectangleShape_getPosition, libcsfml_graphics), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_origin(shape::RectangleShape)
    ccall((:sfRectangleShape_getOrigin, libcsfml_graphics), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_rotation(shape::RectangleShape)
    ccall((:sfRectangleShape_getRotation, libcsfml_graphics), Cfloat, (Ptr{Void},), shape.ptr)
end

function get_scale(shape::RectangleShape)
    ccall((:sfRectangleShape_getScale, libcsfml_graphics), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_size(shape::RectangleShape)
    ccall((:sfRectangleShape_getSize, libcsfml_graphics), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_fillcolor(shape::RectangleShape)
    ccall((:sfRectangleShape_getFillColor, libcsfml_graphics), Color, (Ptr{Void},), shape.ptr)
end

function get_outlinecolor(shape::RectangleShape)
    ccall((:sfRectangleShape_getOutlineColor, libcsfml_graphics), Color, (Ptr{Void},), shape.ptr)
end

function get_outline_thickness(shape::RectangleShape)
    ccall((:sfRectangleShape_getOutlineThickness, libcsfml_graphics), Cfloat, (Ptr{Void},), shape.ptr)
end

function move(shape::RectangleShape, offset::Vector2f)
    ccall((:sfRectangleShape_move, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), shape.ptr, offset)
end

function rotate(shape::RectangleShape, angle::Real)
    ccall((:sfRectangleShape_rotate, libcsfml_graphics), Void, (Ptr{Void}, Cfloat,), shape.ptr, angle)
end

function scale(shape::RectangleShape, factors::Vector2f)
    ccall((:sfRectangleShape_scale, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), shape.ptr, factors)
end

function get_texture(shape::RectangleShape)
    Texture(ccall((:sfRectangleShape_getTexture, libcsfml_graphics), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function get_texture_rect(shape::RectangleShape)
    ccall((:sfRectangleShape_getTextureRect, libcsfml_graphics), IntRect, (Ptr{Void},), shape.ptr)
end

function get_localbounds(shape::RectangleShape)
    ccall((:sfRectangleShape_getLocalBounds, libcsfml_graphics), FloatRect, (Ptr{Void},), shape.ptr)
end

function get_globalbounds(shape::RectangleShape)
    ccall((:sfRectangleShape_getGlobalBounds, libcsfml_graphics), FloatRect, (Ptr{Void},), shape.ptr)
end
