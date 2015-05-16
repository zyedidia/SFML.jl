@enum(WindowStyle, 
window_none = 0, 
window_titlebar = 1 << 0, 
window_resize = 1 << 1, 
window_close = 1 << 2, 
window_fullscreen = 1 << 3, 
window_defaultstyle = (1 << 0) | (1 << 1) | (1 << 2))

type ContextSettings
	depth_bits::Uint32
	stencil_bits::Uint32
	antialiasing_level::Uint32
	major_version::Uint32
	minor_version::Uint32
	attribute_flags::Uint32

	function ContextSettings(depth_bits::Integer, stencil_bits::Integer, antialiasing_level::Integer, major_version::Integer, minor_version::Integer)
		new(depth_bits, stencil_bits, antialiasing_level, major_version, minor_version, 0)
	end
	function ContextSettings()
		new(0, 0, 0, 2, 2, 0)
	end
end

function RenderWindow(mode::VideoMode, title::String, settings::ContextSettings, style::WindowStyle...)
	style_int = 0
	for i = 1:length(style)
		style_int |= Int(style[i])
	end
	settings_ptr = pointer_from_objref(settings)
	icon = Image("$(Pkg.dir("SFML"))/assets/sfmljl_icon.png")
	window = RenderWindow(ccall(dlsym(libcsfml_graphics, :sfRenderWindow_create), Ptr{Void}, (VideoMode, Ptr{Cchar}, Uint32, Ptr{Void},), mode, pointer(title), style_int, settings_ptr))
	set_icon(window, icon, 64, 64)
	return window
end

function RenderWindow(mode::VideoMode, title::String, style::WindowStyle...)
	return RenderWindow(mode, title, ContextSettings(), style[1])
end

function RenderWindow(title::String, width::Integer, height::Integer)
	mode = VideoMode(width, height)
	return RenderWindow(mode, title, window_defaultstyle)
end

function set_framerate_limit(window::RenderWindow, limit::Integer)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_setFramerateLimit), Void, (Ptr{Void}, Uint,), window.ptr, limit)
end

function set_vsync_enabled(window::RenderWindow, enabled::Bool)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_setVerticalSyncEnabled), Void, (Ptr{Void}, Int32,), window.ptr, enabled)
end

function isopen(window::RenderWindow)
	return Bool(ccall(dlsym(libcsfml_graphics, :sfRenderWindow_isOpen), Int32, (Ptr{Void},), window.ptr))
end

function pollevent(window::RenderWindow, event::Event)
	return Bool(ccall(dlsym(libcsfml_graphics, :sfRenderWindow_pollEvent), Int32, (Ptr{Void}, Ptr{Void},), window.ptr, event.ptr))
end

function waitevent(window::RenderWindow, event::Event)
	return Bool(ccall(dlsym(libcsfml_graphics, :sfRenderWindow_waitEvent), Int32, (Ptr{Void}, Ptr{Void},), window.ptr, event.ptr))
end

function set_position(window::RenderWindow, pos::Vector2)
	pos = to_vec2i(pos)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_setPosition), Void, (Ptr{Void}, Vector2i,), window.ptr, pos)
end

function get_position(window::RenderWindow)
	return ccall(dlsym(libcsfml_graphics, :sfRenderWindow_getPosition), Vector2i, (Ptr{Void},), window.ptr)
end

function set_size(window::RenderWindow, size::Vector2)
	size = to_vec2u(size)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_setSize), Void, (Ptr{Void}, Vector2u), window.ptr, size)
end

function get_size(window::RenderWindow)
	return to_vec2i(ccall(dlsym(libcsfml_graphics, :sfRenderWindow_getSize), Vector2u, (Ptr{Void},), window.ptr))
end

function set_title(window::RenderWindow, title::String)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_setTitle), Void, (Ptr{Void}, Ptr{Cchar},), window.ptr, pointer(title))
end

function set_icon(window::RenderWindow, pixels::Array{Uint8}, width=64, height=64)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_setIcon), Void, (Ptr{Void}, Uint32, Uint32, Ptr{Uint8},), window.ptr, width, height, pointer(pixels))
end

function set_icon(window::RenderWindow, image::Image, width=64, height=64)
	set_icon(window, get_pixels(image), width, height)
end

function set_visible(window::RenderWindow, visible::Bool)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_setVisible), Void, (Ptr{Void}, Int32,), window.ptr, visible)
end

function set_mousecursor_visible(window::RenderWindow, visible::Bool)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_setMouseCursorVisible), Void, (Ptr{Void}, Int32,), window.ptr, visible)
end

function set_keyrepeat_enabled(window::RenderWindow, enabled::Bool)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_setKeyRepeatEnabled), Void, (Ptr{Void}, Int32,), window.ptr, enabled)
end

function set_active(window::RenderWindow, active::Bool)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_setActive), Void, (Ptr{Void}, Int32,), window.ptr, active)
end

function requestfocus(window::RenderWindow)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_requestFocus), Void, (Ptr{Void},), window.ptr)
end

function hasfocus(window::RenderWindow)
	return Bool(ccall(dlsym(libcsfml_graphics, :sfRenderWindow_hasFocus), Int32, (Ptr{Void},), window.ptr))
end

function set_view(window::RenderWindow, view::View)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_setView), Void, (Ptr{Void}, Ptr{Void},), window.ptr, view.ptr)
	window._view = view
end

function get_view(window::RenderWindow)
	return View(ccall(dlsym(libcsfml_graphics, :sfRenderWindow_getView), Ptr{Void}, (Ptr{Void},), window.ptr))
end

function get_default_view(window::RenderWindow)
	return View(ccall(dlsym(libcsfml_graphics, :sfRenderWindow_getDefaultView), Ptr{Void}, (Ptr{Void},), window.ptr))
end

function get_viewport(window::RenderWindow)
	return ccall(dlsym(libcsfml_graphics, :sfRenderWindow_getViewport), IntRect, (Ptr{Void},), window.ptr)
end

function draw(window::RenderWindow, object::Drawable, renderStates::RenderStates)
	ptr = pointer_from_objref(renderStates)
	draw(window, object, ptr)
end

function draw(window::RenderWindow, object::Drawable)
	draw(window, object, C_NULL)
end

function draw(window::RenderWindow, object::CircleShape, renderStates::Ptr{Void})
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_drawCircleShape), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function draw(window::RenderWindow, object::RectangleShape, renderStates::Ptr{Void})
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_drawRectangleShape), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function draw(window::RenderWindow, object::Sprite, renderStates::Ptr{Void})
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_drawSprite), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function draw(window::RenderWindow, object::RenderText, renderStates::Ptr{Void})
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_drawText), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function draw(window::RenderWindow, object::ConvexShape, renderStates::Ptr{Void})
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_drawConvexShape), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function draw(window::RenderWindow, object::VertexArray, renderStates::Ptr{Void})
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_drawVertexArray), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function clear(window::RenderWindow, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_clear), Void, (Ptr{Void}, Color,), window.ptr, color)
end

function display(window::RenderWindow)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_display), Void, (Ptr{Void},), window.ptr)
end

function close(window::RenderWindow)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_close), Void, (Ptr{Void},), window.ptr)
end

function destroy(window::RenderWindow)
	ccall(dlsym(libcsfml_graphics, :sfRenderWindow_destroy), Void, (Ptr{Void},), window.ptr)
end

function capture(window::RenderWindow)
	return Image(ccall(dlsym(libcsfml_graphics, :sfRenderWindow_capture), Ptr{Void}, (Ptr{Void},), window.ptr))
end

function pixel2coords(window::RenderWindow, point::Vector2, targetview::View=get_view(window))
	point = to_vec2i(point)
	return ccall(dlsym(libcsfml_graphics, :sfRenderWindow_mapPixelToCoords), Vector2f, (Ptr{Void}, Vector2i, Ptr{Void},), window.ptr, point, targetview.ptr)
end

function coords2pixel(window::RenderWindow, point::Vector2, targetview::View=get_view(window))
	point = to_vec2f(point)
	return ccall(dlsym(libcsfml_graphics, :sfRenderWindow_mapCoordsToPixel), Vector2i, (Ptr{Void}, Vector2f, Ptr{Void},), window.ptr, point, targetview.ptr)
end

export RenderWindow, set_framerate_limit, isopen, pollevent, draw, clear, display, close, set_vsync_enabled, 
capture, ContextSettings, WindowStyle, window_none, window_resize, window_defaultstyle, window_close, window_fullscreen,
set_view, get_view, get_default_view, ContextSettings, set_position, get_position, set_size, get_size, set_title,
waitevent, set_visible, set_mousecursor_visible, set_keyrepeat_enabled, set_active, requestfocus, hasfocus,
pixel2coords, coords2pixel, set_icon
