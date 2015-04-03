type View
	ptr::Ptr{Void}
end

function View()
	return View(ccall((:sfView_create, "libcsfml-graphics"), Ptr{Void}, ()))
end

function View(rect::FloatRect)
	return View(ccall((:sfView_createFromRect, "libcsfml-graphics"), Ptr{Void}, (FloatRect,), rect))
end

function copy(view::View)
	return View(ccall((:sfView_copy, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), view.ptr))
end

function destroy(view::View)
	ccall((:sfView_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), view.ptr)
	view = nothing
end

function set_center(view::View, pos::Vector2f)
	ccall((:sfView_setCenter, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), view.ptr, pos)
end

function set_size(view::View, size::Vector2f)
	ccall((:sfView_setSize, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), view.ptr, size)
end

function set_rotation(view::View, angle::Real)
	ccall((:sfView_setRotation, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), view.ptr, angle)
end

function set_viewport(view::View, rect::FloatRect)
	ccall((:sfView_setViewport, "libcsfml-graphics"), Void, (Ptr{Void}, FloatRect,), view.ptr)
end

function reset(view::View, rect::FloatRect)
	ccall((:sfView_reset, "libcsfml-graphics"), Void, (Ptr{Void}, FloatRect,), view.ptr)
end

function get_center(view::View)
	return ccall((:sfView_getCenter, "libcsfml-graphics"), Vector2f, (Ptr{Void},), view.ptr)
end

function get_size(view::View)
	return ccall((:sfView_getSize, "libcsfml-graphics"), Vector2f, (Ptr{Void},), view.ptr)
end

function get_rotation(view::View)
	return Real(ccall((:sfView_getRotation, "libcsfml-graphics"), Cfloat, (Ptr{Void},), view.ptr))
end

function get_viewport(view::View)
	return ccall((:sfView_getViewport, "libcsfml-graphics"), FloatRect, (Ptr{Void},), view.ptr)
end

function move(view::View, offset::Vector2f)
	ccall((:sfView_move, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), view.ptr, offset)
end

function rotate(view::View, angle::Real)
	ccall((:sfView_rotate, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), view.ptr, angle)
end

function zoom(view::View, factor::Real)
	ccall((:sfView_zoom, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), view.ptr, factor)
end

export zoom, rotate, move, get_viewport, get_rotation, get_size, get_center, reset, set_viewport, set_rotation, set_size, set_center, destroy, copy, View
