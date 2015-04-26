baremodule MouseButton
	const LEFT = 0
	const RIGHT = 1
	const MIDDLE = 2
	const XBUTTON1 = 3
	const XBUTTON2 = 4
end

function is_mouse_pressed(button::Int)
	return Bool(ccall(dlsym(libcsfml_window, :sfMouse_isButtonPressed), Int32, (Int32,), button))
end

function get_mousepos(window::RenderWindow)
	return ccall(dlsym(libcsfml_window, :sfMouse_getPosition), Vector2i, (Ptr{Void},), window.ptr)
end

function set_mousepos(position::Vector2, window::RenderWindow)
	position = to_vec2i(position)
	ccall(dlsym(libcsfml_window, :sfMouse_setPosition), Void, (Vector2i, Ptr{Void},), position, window.ptr)
end

export MouseButton, get_mousepos, set_mousepos, is_mouse_pressed
