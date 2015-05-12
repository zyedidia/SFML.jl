type RenderTexture
	ptr::Ptr{Void}
	_view::View

	function RenderTexture(ptr::Ptr{Void})
		r = new(ptr)
		finalizer(r, destroy)
		r
	end
	
end

function RenderTexture(width::Integer, height::Integer, depth_buffer::Bool=false)
	RenderTexture(ccall(dlsym(libcsfml_graphics, :sfRenderTexture_create), Ptr{Void}, (Uint32, Uint32, Int32,), width, height, depth_buffer))
end

function destroy(texture::RenderTexture)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_destroy), Void, (Ptr{Void},), texture.ptr)
end

function get_size(texture::RenderTexture)
	return to_vec2i(ccall(dlsym(libcsfml_graphics, :sfRenderTexture_getSize), Vector2u, (Ptr{Void},), texture.ptr))
end

function set_active(texture::RenderTexture, active::Bool)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_setActive), Void, (Ptr{Void}, Int32,), texture.ptr, active)
end

function display(texture::RenderTexture)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_display), Void, (Ptr{Void},), texture.ptr)
end

function clear(texture::RenderTexture, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_clear), Void, (Ptr{Void}, Color,), texture.ptr, color)
end

function set_view(texture::RenderTexture, view::View)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_setView), Void, (Ptr{Void}, Ptr{Void},), texture.ptr, view.ptr)
	texture._view = view
end

function get_view(texture::RenderTexture)
	View(ccall(dlsym(libcsfml_graphics, :sfRenderTexture_getView), Ptr{Void}, (Ptr{Void},), texture.ptr))
end

function get_default_view(texture::RenderTexture)
	View(ccall(dlsym(libcsfml_graphics, :sfRenderTexture_getDefaultView), Ptr{Void}, (Ptr{Void},), texture.ptr))
end

function get_viewport(texture::RenderTexture)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_getViewport), IntRect, (Ptr{Void},), texture.ptr)
end

function pixel2coords(texture::RenderTexture, point::Vector2, targetview::View=get_view(texture))
	point = to_vec2i(point)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_mapPixelToCoords), Vector2f, (Ptr{Void}, Vector2i, Ptr{Void},), texture.ptr, point, targetview.ptr)
end

function coords2pixel(texture::RenderTexture, point::Vector2, targetview=get_view(texture))
	point = to_vec2f(point)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_mapCoordsToPixel), Vector2i, (ptr{Void}, Vector2f, Ptr{Void},), texture.ptr, point, targetview.ptr)
end

function draw(texture::RenderTexture, object::Sprite)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_drawSprite), Void, (Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr)
end

function draw(texture::RenderTexture, object::RenderText)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_drawText), Void, (Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr)
end

function draw(texture::RenderTexture, object::CircleShape)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_drawCircleShape), Void, (Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr)
end

function draw(texture::RenderTexture, object::ConvexShape)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_drawConvexShape), Void, (Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr)
end

function draw(texture::RenderTexture, object::RectangleShape)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_drawRectangleShape), Void, (Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr)
end

function draw(texture::RenderTexture, object::VertexArray)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_drawVertexArray), Void, (Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr)
end

function get_texture(texture::RenderTexture)
	return Texture(ccall(dlsym(libcsfml_graphics, :sfRenderTexture_getTexture), Ptr{Void}, (Ptr{Void},), texture.ptr))
end

function set_smooth(texture::RenderTexture, smooth::Bool)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_setSmooth), Void, (Ptr{Void}, Int32,), texture.ptr, smooth)
end

function is_smooth(texture::RenderTexture)
	Bool(ccall(dlsym(libcsfml_graphics, :sfRenderText_isSmooth), Int32, (Ptr{Void},), texture.ptr))
end

function set_repeated(texture::RenderTexture, repeated::Bool)
	ccall(dlsym(libcsfml_graphics, :sfRenderTexture_setRepeated), Void, (Ptr{Void}, Int32,), texture.ptr, repeated)
end

function is_repeated(texture::RenderTexture)
	Bool(ccall(dlsym(libcsfml_graphics, :sfRenderTexture_isRepeated), Int32, (Ptr{Void},), texture.ptr))
end

export RenderTexture, get_size, set_active, display, clear, set_view, get_view, get_default_view, get_viewport,
draw, get_texture, set_smooth, is_smooth, set_repeated, is_repeated, pixel2coords,
coords2pixel
