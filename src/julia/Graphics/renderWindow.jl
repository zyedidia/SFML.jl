@enum(WindowStyle,
window_none = 0,
window_titlebar = 1 << 0,
window_resize = 1 << 1,
window_close = 1 << 2,
window_fullscreen = 1 << 3,
window_defaultstyle = (1 << 0) | (1 << 1) | (1 << 2))

type ContextSettings
    depth_bits::UInt32
    stencil_bits::UInt32
    antialiasing_level::UInt32
    major_version::UInt32
    minor_version::UInt32
    attribute_flags::UInt32

    function ContextSettings(depth_bits::Integer, stencil_bits::Integer, antialiasing_level::Integer, major_version::Integer, minor_version::Integer)
        new(depth_bits, stencil_bits, antialiasing_level, major_version, minor_version, 0)
    end
    function ContextSettings()
        new(0, 0, 0, 2, 2, 0)
    end
end

function RenderWindow(mode::VideoMode, title::AbstractString, settings::ContextSettings, style::WindowStyle...)
    style_int = 0
    for i = 1:length(style)
        style_int |= Int(style[i])
    end
    settings_ptr = Ref(settings)
    icon = Image(joinpath(dirname(@__FILE__),"..","..","..","assets","sfmljl_icon.png"))
    window = RenderWindow(ccall((:sfRenderWindow_create, libcsfml_graphics), Ptr{Void}, (VideoMode, Ptr{Cchar}, UInt32, Ref{ContextSettings},), mode, title, style_int, settings_ptr))
    # set_icon(window, icon, 64, 64)
    return window
end

function RenderWindow(mode::VideoMode, title::AbstractString, style::WindowStyle...=window_defaultstyle)
    return RenderWindow(mode, title, ContextSettings(), style[1])
end

function RenderWindow(title::AbstractString, width::Integer, height::Integer)
    mode = VideoMode(width, height)
    return RenderWindow(mode, title, window_defaultstyle)
end

function set_framerate_limit(window::RenderWindow, limit::Integer)
    ccall((:sfRenderWindow_setFramerateLimit, libcsfml_graphics), Void, (Ptr{Void}, UInt,), window.ptr, limit)
end

function set_vsync_enabled(window::RenderWindow, enabled::Bool)
    ccall((:sfRenderWindow_setVerticalSyncEnabled, libcsfml_graphics), Void, (Ptr{Void}, Int32,), window.ptr, enabled)
end

function isopen(window::RenderWindow)
    return Bool(ccall((:sfRenderWindow_isOpen, libcsfml_graphics), Int32, (Ptr{Void},), window.ptr))
end

function pollevent(window::RenderWindow, event::Event)
    return Bool(ccall((:sfRenderWindow_pollEvent, libcsfml_graphics), Int32, (Ptr{Void}, Ptr{Void},), window.ptr, event.ptr))
end

function waitevent(window::RenderWindow, event::Event)
    return Bool(ccall((:sfRenderWindow_waitEvent, libcsfml_graphics), Int32, (Ptr{Void}, Ptr{Void},), window.ptr, event.ptr))
end

function set_position(window::RenderWindow, pos::Vector2)
    pos = to_vec2i(pos)
    ccall((:sfRenderWindow_setPosition, libcsfml_graphics), Void, (Ptr{Void}, Vector2i,), window.ptr, pos)
end

function get_position(window::RenderWindow)
    return ccall((:sfRenderWindow_getPosition, libcsfml_graphics), Vector2i, (Ptr{Void},), window.ptr)
end

function set_size(window::RenderWindow, window_size::Vector2)
    window_size = to_vec2u(window_size)
    ccall((:sfRenderWindow_setSize, libcsfml_graphics), Void, (Ptr{Void}, Vector2u), window.ptr, window_size)
end

function get_size(window::RenderWindow)
    return to_vec2i(ccall((:sfRenderWindow_getSize, libcsfml_graphics), Vector2u, (Ptr{Void},), window.ptr))
end

function set_title(window::RenderWindow, title::AbstractString)
    ccall((:sfRenderWindow_setTitle, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Cchar},), window.ptr, title)
end

function set_icon(window::RenderWindow, pixels::Array{UInt8}, width=64, height=64)
    ccall((:sfRenderWindow_setIcon, libcsfml_graphics), Void, (Ptr{Void}, UInt32, UInt32, Ptr{UInt8},), window.ptr, width, height, pointer(pixels))
end

function set_icon(window::RenderWindow, image::Image, width=64, height=64)
    set_icon(window, get_pixels(image), width, height)
end

function set_visible(window::RenderWindow, visible::Bool)
    ccall((:sfRenderWindow_setVisible, libcsfml_graphics), Void, (Ptr{Void}, Int32,), window.ptr, visible)
end

function set_mousecursor_visible(window::RenderWindow, visible::Bool)
    ccall((:sfRenderWindow_setMouseCursorVisible, libcsfml_graphics), Void, (Ptr{Void}, Int32,), window.ptr, visible)
end

function set_keyrepeat_enabled(window::RenderWindow, enabled::Bool)
    ccall((:sfRenderWindow_setKeyRepeatEnabled, libcsfml_graphics), Void, (Ptr{Void}, Int32,), window.ptr, enabled)
end

function set_active(window::RenderWindow, active::Bool)
    ccall((:sfRenderWindow_setActive, libcsfml_graphics), Void, (Ptr{Void}, Int32,), window.ptr, active)
end

function requestfocus(window::RenderWindow)
    ccall((:sfRenderWindow_requestFocus, libcsfml_graphics), Void, (Ptr{Void},), window.ptr)
end

function hasfocus(window::RenderWindow)
    return Bool(ccall((:sfRenderWindow_hasFocus, libcsfml_graphics), Int32, (Ptr{Void},), window.ptr))
end

function set_view(window::RenderWindow, view::View)
    ccall((:sfRenderWindow_setView, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Void},), window.ptr, view.ptr)
    window._view = view
end

function get_view(window::RenderWindow)
    return View(ccall((:sfRenderWindow_getView, libcsfml_graphics), Ptr{Void}, (Ptr{Void},), window.ptr))
end

function get_default_view(window::RenderWindow)
    return View(ccall((:sfRenderWindow_getDefaultView, libcsfml_graphics), Ptr{Void}, (Ptr{Void},), window.ptr))
end

function get_viewport(window::RenderWindow)
    return ccall((:sfRenderWindow_getViewport, libcsfml_graphics), IntRect, (Ptr{Void},), window.ptr)
end

function draw(window::RenderWindow, object::Drawable, shader::Shader)
    state = RenderStates(shader)
    draw(window, object, state)
end

function draw(window::RenderWindow, object::Drawable, state::RenderStates)
    draw(window, object, state.ptr)
end

function draw(window::RenderWindow, object::Drawable)
    draw(window, object, C_NULL)
end

function draw(window::RenderWindow, object::CircleShape, renderStates::Ptr{Void})
    ccall((:sfRenderWindow_drawCircleShape, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function draw(window::RenderWindow, object::RectangleShape, renderStates::Ptr{Void})
    ccall((:sfRenderWindow_drawRectangleShape, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function draw(window::RenderWindow, object::Sprite, renderStates::Ptr{Void})
    ccall((:sfRenderWindow_drawSprite, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function draw(window::RenderWindow, object::RenderText, renderStates::Ptr{Void})
    ccall((:sfRenderWindow_drawText, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function draw(window::RenderWindow, object::ConvexShape, renderStates::Ptr{Void})
    ccall((:sfRenderWindow_drawConvexShape, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function draw(window::RenderWindow, object::VertexArray, renderStates::Ptr{Void})
    ccall((:sfRenderWindow_drawVertexArray, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), window.ptr, object.ptr, renderStates)
end

function clear(window::RenderWindow, color::Color)
    ccall((:sfRenderWindow_clear, libcsfml_graphics), Void, (Ptr{Void}, Color,), window.ptr, color)
end

function display(window::RenderWindow)
    ccall((:sfRenderWindow_display, libcsfml_graphics), Void, (Ptr{Void},), window.ptr)
end

function close(window::RenderWindow)
    ccall((:sfRenderWindow_close, libcsfml_graphics), Void, (Ptr{Void},), window.ptr)
end

function destroy(window::RenderWindow)
    ccall((:sfRenderWindow_destroy, libcsfml_graphics), Void, (Ptr{Void},), window.ptr)
end

function capture(window::RenderWindow)
    return Image(ccall((:sfRenderWindow_capture, libcsfml_graphics), Ptr{Void}, (Ptr{Void},), window.ptr))
end

function pixel2coords(window::RenderWindow, point::Vector2, targetview::View=get_view(window))
    point = to_vec2i(point)
    return ccall((:sfRenderWindow_mapPixelToCoords, libcsfml_graphics), Vector2f, (Ptr{Void}, Vector2i, Ptr{Void},), window.ptr, point, targetview.ptr)
end

function coords2pixel(window::RenderWindow, point::Vector2, targetview::View=get_view(window))
    point = to_vec2f(point)
    return ccall((:sfRenderWindow_mapCoordsToPixel, libcsfml_graphics), Vector2i, (Ptr{Void}, Vector2f, Ptr{Void},), window.ptr, point, targetview.ptr)
end
