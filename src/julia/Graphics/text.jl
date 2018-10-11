mutable struct RenderText <: Drawable
    ptr::Ptr{Nothing}
    _font::Font

    function RenderText(ptr::Ptr{Nothing})
        t = new(ptr)
        finalizer(t, destroy)
        t
    end
end

const TextRegular = 0
const TextBold = 1 << 0
const TextItalic = 1 << 1
const TextUnderlined = 1 << 2
const TextStrikeThrough = 1 << 3

function RenderText()
    r = RenderText(ccall((:sfText_create, libcsfml_graphics), Ptr{Nothing}, ()))
    set_font(r, Font(joinpath(dirname(@__FILE__),"..","..","..","assets","arial.ttf")))
    r
end

function RenderText(value::AbstractString)
    r = RenderText()
    set_string(r, value)
    r
end

function copy(text::RenderText)
    return RenderText(ccall((:sfText_copy, libcsfml_graphics), Ptr{Nothing}, (Ptr{Nothing},), text.ptr))
end

function destroy(text::RenderText)
    ccall((:sfText_destroy, libcsfml_graphics), Nothing, (Ptr{Nothing},), text.ptr)
end

function set_position(text::RenderText, pos::Vector2f)
    ccall((:sfText_setPosition, libcsfml_graphics), Nothing, (Ptr{Nothing}, Vector2f,), text.ptr, pos)
end

function set_rotation(text::RenderText, angle::Real)
    ccall((:sfText_setRotation, libcsfml_graphics), Nothing, (Ptr{Nothing}, Cfloat,), text.ptr, angle)
end

function set_scale(text::RenderText, scale::Vector2f)
    ccall((:sfText_setScale, libcsfml_graphics), Nothing, (Ptr{Nothing}, Vector2f), text.ptr, scale)
end

function set_origin(text::RenderText, origin::Vector2f)
    ccall((:sfText_setOrigin, libcsfml_graphics), Nothing, (Ptr{Nothing}, Vector2f,), text.ptr, origin)
end

function get_position(text::RenderText)
    return ccall((:sfText_getPosition, libcsfml_graphics), Vector2f, (Ptr{Nothing},), text.ptr)
end

function get_rotation(text::RenderText)
    ccall((:sfText_getRotation, libcsfml_graphics), Cfloat, (Ptr{Nothing},), text.ptr)
end

function get_scale(text::RenderText)
    ccall((:sfText_getScale, libcsfml_graphics), Vector2f, (Ptr{Nothing},), text.ptr)
end

function get_origin(text::RenderText)
    ccall((:sfText_getOrigin, libcsfml_graphics), Vector2f, (Ptr{Nothing},), text.ptr)
end

function move(text::RenderText, offsets::Vector2f)
    ccall((:sfText_move, libcsfml_graphics), Nothing, (Ptr{Nothing}, Vector2f,), text.ptr, offsets)
end

function rotate(text::RenderText, angle::Real)
    ccall((:sfText_rotate, libcsfml_graphics), Nothing, (Ptr{Nothing}, Cfloat,), text.ptr, angle)
end

function scale(text::RenderText, factors::Vector2f)
    ccall((:sfText_scale, libcsfml_graphics), Nothing, (Ptr{Nothing}, Vector2f,), text.ptr, factors)
end

function set_string(text::RenderText, string::AbstractString)
    ccall((:sfText_setString, libcsfml_graphics), Nothing, (Ptr{Nothing}, Ptr{Cchar},), text.ptr, string)
end

function set_font(text::RenderText, font::Font)
    ccall((:sfText_setFont, libcsfml_graphics), Nothing, (Ptr{Nothing}, Ptr{Nothing},), text.ptr, font.ptr)
    text._font = font
end

function set_charactersize(text::RenderText, size::Integer)
    ccall((:sfText_setCharacterSize, libcsfml_graphics), Nothing, (Ptr{Nothing}, UInt32,), text.ptr, size)
end

function set_style(text::RenderText, style::Integer)
    ccall((:sfText_setStyle, libcsfml_graphics), Nothing, (Ptr{Nothing}, UInt32,), text.ptr, style)
end

function set_color(text::RenderText, color::Color)
    ccall((:sfText_setColor, libcsfml_graphics), Nothing, (Ptr{Nothing}, Color,), text.ptr, color)
end

function set_style(text::RenderText, style::UInt32)
    ccall((:sfText_setStyle, libcsfml_graphics), Nothing, (Ptr{Nothing}, UInt32,), text.ptr, style)
end

function get_string(text::RenderText)
    unsafe_string(ccall((:sfText_getString, libcsfml_graphics), Ptr{Cchar}, (Ptr{Nothing},), text.ptr))
end

function get_font(text::RenderText)
    Font(ccall((:sfText_getFont, libcsfml_graphics), Ptr{Nothing}, (Ptr{Nothing},), text.ptr))
end

function get_charactersize(text::RenderText)
    Int(ccall((:sfText_getCharacterSize, libcsfml_graphics), UInt32, (Ptr{Nothing},), text.ptr))
end

function get_style(text::RenderText)
    Int(ccall((:sfText_getStyle, libcsfml_graphics), UInt32, (Ptr{Nothing},), text.ptr))
end

function get_color(text::RenderText)
    ccall((:sfText_getColor, libcsfml_graphics), Color, (Ptr{Nothing},), text.ptr)
end

function find_character_pos(text::RenderText, index::Integer)
    ccall((:sfText_findCharacterPos, libcsfml_graphics), Vector2f, (Ptr{Nothing}, Csize_t,), text.ptr, index)
end

function get_localbounds(text::RenderText)
    ccall((:sfText_getLocalBounds, libcsfml_graphics), FloatRect, (Ptr{Nothing},), text.ptr)
end

function get_globalbounds(text::RenderText)
    ccall((:sfText_getGlobalBounds, libcsfml_graphics), FloatRect, (Ptr{Nothing},), text.ptr)
end
