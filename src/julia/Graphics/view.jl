type View
	ptr::Ptr{Void}

	function View(ptr::Ptr{Void})
		v = new(ptr)
		# finalizer(v, destroy)
		# v
	end
end

function View()
	View(ccall(dlsym(libcsfml_graphics, :sfView_create), Ptr{Void}, ()))
end

function View(rect::FloatRect)
	View(ccall(dlsym(libcsfml_graphics, :sfView_createFromRect), Ptr{Void}, (FloatRect,), rect))
end

function View(center::Vector2f, size::Vector2f)
	v = View()
	set_center(v, center)
	set_size(v, size)
	v
end

function copy(view::View)
	return View(ccall(dlsym(libcsfml_graphics, :sfView_copy), Ptr{Void}, (Ptr{Void},), view.ptr))
end

function destroy(view::View)
	println("destroyed view")
	ccall(dlsym(libcsfml_graphics, :sfView_destroy), Void, (Ptr{Void},), view.ptr)
end

function set_center(view::View, pos::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfView_setCenter), Void, (Ptr{Void}, Vector2f,), view.ptr, pos)
end

function set_size(view::View, size::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfView_setSize), Void, (Ptr{Void}, Vector2f,), view.ptr, size)
end

function set_rotation(view::View, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfView_setRotation), Void, (Ptr{Void}, Cfloat,), view.ptr, angle)
end

function set_viewport(view::View, rect::FloatRect)
	ccall(dlsym(libcsfml_graphics, :sfView_setViewport), Void, (Ptr{Void}, FloatRect,), view.ptr, rect)
end

function reset(view::View, rect::FloatRect)
	ccall(dlsym(libcsfml_graphics, :sfView_reset), Void, (Ptr{Void}, FloatRect,), view.ptr, rect)
end

function get_center(view::View)
	return ccall(dlsym(libcsfml_graphics, :sfView_getCenter), Vector2f, (Ptr{Void},), view.ptr)
end

function get_size(view::View)
	return ccall(dlsym(libcsfml_graphics, :sfView_getSize), Vector2f, (Ptr{Void},), view.ptr)
end

function get_rotation(view::View)
	return Real(ccall(dlsym(libcsfml_graphics, :sfView_getRotation), Cfloat, (Ptr{Void},), view.ptr))
end

function get_viewport(view::View)
	return ccall(dlsym(libcsfml_graphics, :sfView_getViewport), FloatRect, (Ptr{Void},), view.ptr)
end

function move(view::View, offset::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfView_move), Void, (Ptr{Void}, Vector2f,), view.ptr, offset)
end

function rotate(view::View, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfView_rotate), Void, (Ptr{Void}, Cfloat,), view.ptr, angle)
end

function zoom(view::View, factor::Real)
	ccall(dlsym(libcsfml_graphics, :sfView_zoom), Void, (Ptr{Void}, Cfloat,), view.ptr, factor)
end

export zoom, rotate, move, get_viewport, get_rotation, get_size, get_center, reset, set_viewport,
set_rotation, set_size, set_center, copy, View
