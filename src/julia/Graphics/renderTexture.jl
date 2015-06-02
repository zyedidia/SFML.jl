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
	RenderTexture(ccall((:sfRenderTexture_create, "libcsfml-graphics"), Ptr{Void}, (Uint32, Uint32, Int32,), width, height, depth_buffer))
end

function destroy(texture::RenderTexture)
	ccall((:sfRenderTexture_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), texture.ptr)
end

function get_size(texture::RenderTexture)
	return to_vec2i(ccall((:sfRenderTexture_getSize, "libcsfml-graphics"), Vector2u, (Ptr{Void},), texture.ptr))
end

function set_active(texture::RenderTexture, active::Bool)
	ccall((:sfRenderTexture_setActive, "libcsfml-graphics"), Void, (Ptr{Void}, Int32,), texture.ptr, active)
end

function display(texture::RenderTexture)
	ccall((:sfRenderTexture_display, "libcsfml-graphics"), Void, (Ptr{Void},), texture.ptr)
end

function clear(texture::RenderTexture, color::Color)
	ccall((:sfRenderTexture_clear, "libcsfml-graphics"), Void, (Ptr{Void}, Color,), texture.ptr, color)
end

function set_view(texture::RenderTexture, view::View)
	ccall((:sfRenderTexture_setView, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void},), texture.ptr, view.ptr)
	texture._view = view
end

function get_view(texture::RenderTexture)
	View(ccall((:sfRenderTexture_getView, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), texture.ptr))
end

function get_default_view(texture::RenderTexture)
	View(ccall((:sfRenderTexture_getDefaultView, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), texture.ptr))
end

function get_viewport(texture::RenderTexture)
	ccall((:sfRenderTexture_getViewport, "libcsfml-graphics"), IntRect, (Ptr{Void},), texture.ptr)
end

function pixel2coords(texture::RenderTexture, point::Vector2, targetview::View=get_view(texture))
	point = to_vec2i(point)
	ccall((:sfRenderTexture_mapPixelToCoords, "libcsfml-graphics"), Vector2f, (Ptr{Void}, Vector2i, Ptr{Void},), texture.ptr, point, targetview.ptr)
end

function coords2pixel(texture::RenderTexture, point::Vector2, targetview=get_view(texture))
	point = to_vec2f(point)
	ccall((:sfRenderTexture_mapCoordsToPixel, "libcsfml-graphics"), Vector2i, (ptr{Void}, Vector2f, Ptr{Void},), texture.ptr, point, targetview.ptr)
end

function draw(texture::RenderTexture, object::Drawable, shader::Shader)
	state = RenderStates(shader)
	draw(texture, object, state)
end

function draw(texture::RenderTexture, object::Drawable, state::RenderStates)
	draw(texture, object, state.ptr)
end

function draw(texture::RenderTexture, object::Drawable)
	draw(texture, object, C_NULL)
end

function draw(texture::RenderTexture, object::CircleShape, renderStates::Ptr{Void})
	ccall((:sfRenderTexture_drawCircleShape, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr, renderStates)
end

function draw(texture::RenderTexture, object::RectangleShape, renderStates::Ptr{Void})
	ccall((:sfRenderTexture_drawRectangleShape, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr, renderStates)
end

function draw(texture::RenderTexture, object::Sprite, renderStates::Ptr{Void})
	ccall((:sfRenderTexture_drawSprite, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr, renderStates)
end

function draw(texture::RenderTexture, object::RenderText, renderStates::Ptr{Void})
	ccall((:sfRenderTexture_drawText, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr, renderStates)
end

function draw(texture::RenderTexture, object::ConvexShape, renderStates::Ptr{Void})
	ccall((:sfRenderTexture_drawConvexShape, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr, renderStates)
end

function draw(texture::RenderTexture, object::VertexArray, renderStates::Ptr{Void})
	ccall((:sfRenderTexture_drawVertexArray, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void}, Ptr{Void},), texture.ptr, object.ptr, renderStates)
end

function get_texture(texture::RenderTexture)
	return Texture(ccall((:sfRenderTexture_getTexture, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), texture.ptr))
end

function set_smooth(texture::RenderTexture, smooth::Bool)
	ccall((:sfRenderTexture_setSmooth, "libcsfml-graphics"), Void, (Ptr{Void}, Int32,), texture.ptr, smooth)
end

function is_smooth(texture::RenderTexture)
	Bool(ccall((:sfRenderText_isSmooth, "libcsfml-graphics"), Int32, (Ptr{Void},), texture.ptr))
end

function set_repeated(texture::RenderTexture, repeated::Bool)
	ccall((:sfRenderTexture_setRepeated, "libcsfml-graphics"), Void, (Ptr{Void}, Int32,), texture.ptr, repeated)
end

function is_repeated(texture::RenderTexture)
	Bool(ccall((:sfRenderTexture_isRepeated, "libcsfml-graphics"), Int32, (Ptr{Void},), texture.ptr))
end

export RenderTexture, get_size, set_active, display, clear, set_view, get_view, get_default_view, get_viewport,
draw, get_texture, set_smooth, is_smooth, set_repeated, is_repeated, pixel2coords,
coords2pixel
