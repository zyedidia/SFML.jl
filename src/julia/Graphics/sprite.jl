type Sprite
	ptr::Ptr{Void}
end

function Sprite()
	return Sprite(ccall(dlsym(libcsfml_graphics, :sfSprite_create), Ptr{Void}, ()))
end

function copy(sprite::Sprite)
	return Sprite(ccall(dlsym(libcsfml_graphics, :sfSprite_copy), Ptr{Void}, (Ptr{Void},), sprite.ptr))
end

function destroy(sprite::Sprite)
	ccall(dlsym(libcsfml_graphics, :sfSprite_destroy), Void, (Ptr{Void},), sprite.ptr)
	sprite = nothing
end

function set_position(sprite::Sprite, position::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfSprite_setPosition), Void, (Ptr{Void}, Vector2f,), sprite.ptr, position)
end

function set_rotation(sprite::Sprite, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfSprite_setRotation), Void, (Ptr{Void}, Cfloat,), sprite.ptr, angle)
end

function set_scale(sprite::Sprite, scale::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfSprite_setScale), Void, (Ptr{Void}, Vector2f,), sprite.ptr, scale)
end

function set_origin(sprite::Sprite, origin::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfSprite_setOrigin), Void, (Ptr{Void}, Vector2f,), sprite.ptr, origin)
end

function get_position(sprite::Sprite)
	return ccall(dlsym(libcsfml_graphics, :sfSprite_getPosition), Vector2f, (Ptr{Void},), sprite.ptr)
end

function get_rotation(sprite::Sprite)
	return Real(ccall(dlsym(libcsfml_graphics, :sfSprite_getRotation), Cfloat, (Ptr{Void},), sprite.ptr))
end

function get_origin(sprite::Sprite)
	return ccall(dlsym(libcsfml_graphics, :sfSprite_getOrigin), Vector2f, (Ptr{Void},), sprite.ptr)
end

function move(sprite::Sprite, offset::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfSprite_move), Void, (Ptr{Void}, Vector2f,), sprite.ptr, offset)
end

function rotate(sprite::Sprite, angle::Real)
	ccall(dlsym(libcsfml_graphics, :sfSprite_rotate), Void, (Ptr{Void}, Cfloat,), sprite.ptr, angle)
end

function scale(sprite::Sprite, factors::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfSprite_scale), Void, (Ptr{Void}, Vector2f,), sprite.ptr, factors)
end

function set_texture(sprite::Sprite, texture::Texture)
	ccall(dlsym(libcsfml_graphics, :sfSprite_setTexture), Void, (Ptr{Void}, Ptr{Void}, Int32,), sprite.ptr, texture.ptr, 1)
end

function set_color(sprite::Sprite, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfSprite_setColor), Void, (Ptr{Void}, Color,), sprite.ptr, color)
end

function get_texture(sprite::Sprite)
	return Texture(ccall(dlsym(sfSprite_getTexture, libcsfml_graphics), Ptr{Void}, (Ptr{Void},), sprite.ptr))
end

function get_color(sprite::Sprite)
	return ccall(dlsym(libcsfml_graphics, :sfSprite_getColor), Color, (Ptr{Void},), sprite.ptr)
end

function get_localbounds(sprite::Sprite)
	return ccall(dlsym(libcsfml_graphics, :sfSprite_getLocalBounds), FloatRect, (Ptr{Void},), sprite.ptr)
end

function get_globalbounds(sprite::Sprite)
	return ccall(dlsym(libcsfml_graphics, :sfSprite_getGlobalBounds), FloatRect, (Ptr{Void},), sprite.ptr)
end

export get_color, get_texture, set_texture, scale, rotate, move, get_origin, get_rotation, get_position, set_origin,
set_scale, set_rotation, set_position, copy, Sprite, destroy, get_localbounds, get_globalbounds
