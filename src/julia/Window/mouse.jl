baremodule MouseButton
    const LEFT = 0
    const RIGHT = 1
    const MIDDLE = 2
    const XBUTTON1 = 3
    const XBUTTON2 = 4
end

function is_mouse_pressed(button::Int)
    return Bool(ccall((:sfMouse_isButtonPressed, libcsfml_window), Int32, (Int32,), button))
end

function get_mousepos(window::RenderWindow)
    return ccall((:sfMouse_getPosition, libcsfml_window), Vector2i, (Ptr{Nothing},), window.ptr)
end

function set_mousepos(pos::Vector2, window::RenderWindow)
    pos = to_vec2i(pos)
    ccall((:sfMouse_setPosition, libcsfml_window), Nothing, (Vector2i, Ptr{Nothing},), pos, window.ptr)
end
