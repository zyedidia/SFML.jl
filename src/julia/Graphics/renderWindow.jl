type RenderWindow
	ptr::Ptr{Void}
end

function RenderWindow(title::ASCIIString, width::Int, height::Int)
	return RenderWindow(ccall((:new_sjRenderWindow, "libjuliasfml"), Ptr{Void}, (Ptr{Cchar}, Int32, Int32,), pointer(title), width, height))
end

function set_framerate_limit(window::RenderWindow, limit::Int)
	ccall((:sfRenderWindow_setFramerateLimit, "libcsfml-graphics"), Void, (Ptr{Void}, Uint,), window.ptr, limit)
end

function set_vsync_enabled(window::RenderWindow, enabled::Bool)
	ccall((:sfRenderWindow_setVerticalSyncEnabled, "libcsfml-graphics"), Void, (Ptr{Void}, Int32,), window.ptr, Int32(enabled))
end

function isopen(window::RenderWindow)
	return (ccall((:sfRenderWindow_isOpen, "libcsfml-graphics"), Int32, (Ptr{Void},), window.ptr)) == 1
end

function pollevent(window::RenderWindow, event::Event)
	return ccall((:sfRenderWindow_pollEvent, "libcsfml-graphics"), Int32, (Ptr{Void}, Ptr{Void},), window.ptr, event.ptr) == 1
end

function draw(window::RenderWindow, object::CircleShape)
	ccall((:sfRenderWindow_drawCircleShape, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, C_NULL)
end

function draw(window::RenderWindow, object::RectangleShape)
	ccall((:sfRenderWindow_drawRectangleShape, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, C_NULL)
end

function clear(window::RenderWindow, color::Color)
	ccall((:sfRenderWindow_clear, "libcsfml-graphics"), Void, (Ptr{Void}, Color,), window.ptr, color)
end

function display(window::RenderWindow)
	ccall((:sfRenderWindow_display, "libcsfml-graphics"), Void, (Ptr{Void},), window.ptr)
end

function close(window::RenderWindow)
	ccall((:sfRenderWindow_close, "libcsfml-graphics"), Void, (Ptr{Void},), window.ptr)
end

function destroy(window::RenderWindow)
	ccall((:sfRenderWindow_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), window.ptr)
	window = nothing
end

export RenderWindow, set_framerate_limit, isopen, pollevent, draw, clear, display, close, destroy, set_vsync_enabled
