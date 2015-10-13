type ConvexShape <: Drawable
    ptr::Ptr{Void}
    _texture::Texture

    function ConvexShape(ptr::Ptr{Void})
        c = new(ptr)
        finalizer(c, destroy)
        c
    end
end

function ConvexShape()
    ConvexShape(ccall((:sfConvexShape_create, libcsfml_graphics), Ptr{Void}, ()))
end

function copy(shape::ConvexShape)
    return ConvexShape(ccall((:sfConvexShape_copy, libcsfml_graphics), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function destroy(shape::ConvexShape)
    ccall((:sfConvexShape_destroy, libcsfml_graphics), Void, (Ptr{Void},), shape.ptr)
end

function set_position(shape::ConvexShape, pos::Vector2f)
    ccall((:sfConvexShape_setPosition, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), shape.ptr, pos)
end

function set_rotation(shape::ConvexShape, angle::Real)
    ccall((:sfConvexShape_setRotation, libcsfml_graphics), Void, (Ptr{Void}, Cfloat,), shape.ptr, angle)
end

function set_scale(shape::ConvexShape, scale::Vector2f)
    ccall((:sfConvexShape_setScale, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), shape.ptr, scale)
end

function set_origin(shape::ConvexShape, origin::Vector2f)
    ccall((:sfConvexShape_setOrigin, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), shape.ptr, origin)
end

function get_position(shape::ConvexShape)
    return ccall((:sfConvexShape_getPosition, libcsfml_graphics), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_rotation(shape::ConvexShape)
    return Real(ccall((:sfConvexShape_getRotation, libcsfml_graphics), Cfloat, (Ptr{Void},), shape.ptr))
end

function get_scale(shape::ConvexShape)
    return ccall((:sfConvexShape_getScale, libcsfml_graphics), Vector2f, (Ptr{Void},), shape.ptr)
end

function get_origin(shape::ConvexShape)
    return ccall((:sfConvexShape_getOrigin, libcsfml_graphics), Vector2f, (Ptr{Void},), shape.ptr)
end

function move(shape::ConvexShape, offset::Vector2f)
    ccall((:sfConvexShape_move, libcsfml_graphics), Void, (Ptr{Void}, Vector2f), shape.ptr, offset)
end

function rotate(shape::ConvexShape, angle::Real)
    ccall((:sfConvexShape_rotate, libcsfml_graphics), Void, (Ptr{Void}, Cfloat,), shape.ptr, angle)
end

function scale(shape::ConvexShape, factors::Vector2f)
    ccall((:sfConvexShape_scale, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), shape.ptr, factors)
end

function set_texture(shape::ConvexShape, texture::Texture)
    ccall((:sfConvexShape_setTexture, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Void},), shape.ptr, texture.ptr)
    shape._texture = texture
end

function set_texture_rect(shape::ConvexShape, rect::IntRect)
    ccall((:sfConvexShape_setTextureRect, libcsfml_graphics), Void, (Ptr{Void}, IntRect,), shape.ptr, rect)
end

function set_fillcolor(shape::ConvexShape, color::Color)
    ccall((:sfConvexShape_setFillColor, libcsfml_graphics), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function set_outlinecolor(shape::ConvexShape, color::Color)
    ccall((:sfConvexShape_setOutlineColor, libcsfml_graphics), Void, (Ptr{Void}, Color,), shape.ptr, color)
end

function set_outline_thickness(shape::ConvexShape, thickness::Real)
    ccall((:sfConvexShape_setOutlineThickness, libcsfml_graphics), Void, (Ptr{Void}, Cfloat,), shape.ptr, thickness)
end

function get_texture(shape::ConvexShape)
    return Texture(ccall((:sfConvexShape_getTexture, libcsfml_graphics), Ptr{Void}, (Ptr{Void},), shape.ptr))
end

function get_texture_rect(shape::ConvexShape)
    return ccall((:sfConvexShape_getTextureRect, libcsfml_graphics), IntRect, (Ptr{Void},), shape.ptr)
end

function get_fillcolor(shape::ConvexShape)
    return ccall((:sfConvexShape_getFillColor, libcsfml_graphics), Color, (Ptr{Void},), shape.ptr)
end

function get_outlinecolor(shape::ConvexShape)
    return ccall((:sfConvexShape_getOutlineColor, libcsfml_graphics), Color, (Ptr{Void},), shape.ptr)
end

function get_outline_thickness(shape::ConvexShape)
    return Real(ccall((:sfConvexShape_getOutlineThickness, libcsfml_graphics), Cfloat, (Ptr{Void},), shape.ptr))
end

function get_pointcount(shape::ConvexShape)
    return Int(ccall((:sfConvexShape_getPointCount, libcsfml_graphics), UInt32, (Ptr{Void},), shape.ptr))
end

function get_point(shape::ConvexShape, index::Integer)
    return ccall((:sfConvexShape_getPoint, libcsfml_graphics), Vector2f, (Ptr{Void}, UInt32,), shape.ptr, index)
end

function set_pointcount(shape::ConvexShape, count::Integer)
    ccall((:sfConvexShape_setPointCount, libcsfml_graphics), Void, (Ptr{Void}, UInt32,), shape.ptr, count)
end

function set_point(shape::ConvexShape, index::Integer, point::Vector2f)
    ccall((:sfConvexShape_setPoint, libcsfml_graphics), Void, (Ptr{Void}, UInt32, Vector2f,), shape.ptr, index, point)
end

function get_localbounds(shape::ConvexShape)
    return ccall((:sfConvexShape_getLocalBounds, libcsfml_graphics), FloatRect, (Ptr{Void},), shape.ptr)
end

function get_globalbounds(shape::ConvexShape)
    return ccall((:sfConvexShape_getGlobalBounds, libcsfml_graphics), FloatRect, (Ptr{Void},), shape.ptr)
end
