type View
    ptr::Ptr{Void}

    function View(ptr::Ptr{Void})
        v = new(ptr)
        # finalizer(v, destroy)
        # v
    end
end

function View()
    View(ccall((:sfView_create, libcsfml_graphics), Ptr{Void}, ()))
end

function View(rect::FloatRect)
    View(ccall((:sfView_createFromRect, libcsfml_graphics), Ptr{Void}, (FloatRect,), rect))
end

function View(center::Vector2f, size::Vector2f)
    v = View()
    set_center(v, center)
    set_size(v, size)
    v
end

function copy(view::View)
    return View(ccall((:sfView_copy, libcsfml_graphics), Ptr{Void}, (Ptr{Void},), view.ptr))
end

function destroy(view::View)
    println("destroyed view")
    ccall((:sfView_destroy, libcsfml_graphics), Void, (Ptr{Void},), view.ptr)
end

function set_center(view::View, pos::Vector2f)
    ccall((:sfView_setCenter, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), view.ptr, pos)
end

function set_size(view::View, size::Vector2f)
    ccall((:sfView_setSize, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), view.ptr, size)
end

function set_rotation(view::View, angle::Real)
    ccall((:sfView_setRotation, libcsfml_graphics), Void, (Ptr{Void}, Cfloat,), view.ptr, angle)
end

function set_viewport(view::View, rect::FloatRect)
    ccall((:sfView_setViewport, libcsfml_graphics), Void, (Ptr{Void}, FloatRect,), view.ptr, rect)
end

function reset(view::View, rect::FloatRect)
    ccall((:sfView_reset, libcsfml_graphics), Void, (Ptr{Void}, FloatRect,), view.ptr, rect)
end

function get_center(view::View)
    return ccall((:sfView_getCenter, libcsfml_graphics), Vector2f, (Ptr{Void},), view.ptr)
end

function get_size(view::View)
    return ccall((:sfView_getSize, libcsfml_graphics), Vector2f, (Ptr{Void},), view.ptr)
end

function get_rotation(view::View)
    return Real(ccall((:sfView_getRotation, libcsfml_graphics), Cfloat, (Ptr{Void},), view.ptr))
end

function get_viewport(view::View)
    return ccall((:sfView_getViewport, libcsfml_graphics), FloatRect, (Ptr{Void},), view.ptr)
end

function move(view::View, offset::Vector2f)
    ccall((:sfView_move, libcsfml_graphics), Void, (Ptr{Void}, Vector2f,), view.ptr, offset)
end

function rotate(view::View, angle::Real)
    ccall((:sfView_rotate, libcsfml_graphics), Void, (Ptr{Void}, Cfloat,), view.ptr, angle)
end

function zoom(view::View, factor::Real)
    ccall((:sfView_zoom, libcsfml_graphics), Void, (Ptr{Void}, Cfloat,), view.ptr, factor)
end
