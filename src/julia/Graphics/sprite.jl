type Sprite
	ptr::Ptr{Void}
end

function Sprite()
	return Sprite(ccall((:sfSprite_create, "libcsfml-graphics"), Ptr{Void}, ()))
end

function copy(sprite::Sprite)
	return Sprite(ccall((:sfSprite_copy, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), sprite.ptr))
end

function destroy(sprite::Sprite)
	ccall((:sfSprite_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), sprite.ptr)
	sprite = nothing
end

function set_position(sprite::Sprite, position::Vector2f)
	ccall((:sfSprite_setPosition, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), sprite.ptr, position)
end

function set_rotation(sprite::Sprite, angle::Real)
	ccall((:sfSprite_setRotation, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), sprite.ptr, angle)
end

function set_scale(sprite::Sprite, scale::Vector2f)
	ccall((:sfSprite_setScale, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), sprite.ptr, scale)
end

function set_origin(sprite::Sprite, origin::Vector2f)
	ccall((:sfSprite_setOrigin, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), sprite.ptr, origin)
end

function get_position(sprite::Sprite)
	return ccall((:sfSprite_getPosition, "libcsfml-graphics"), Vector2f, (Ptr{Void},), sprite.ptr)
end

function get_rotation(sprite::Sprite)
	return Real(ccall((:sfSprite_getRotation, "libcsfml-graphics"), Cfloat, (Ptr{Void},), sprite.ptr))
end

function get_origin(sprite::Sprite)
	return ccall((:sfSprite_getOrigin, "libcsfml-graphics"), Vector2f, (Ptr{Void},), sprite.ptr)
end

function move(sprite::Sprite, offset::Vector2f)
	ccall((:sfSprite_move, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), sprite.ptr, offset)
end

function rotate(sprite::Sprite, angle::Real)
	ccall((:sfSprite_rotate, "libcsfml-graphics"), Void, (Ptr{Void}, Cfloat,), sprite.ptr, angle)
end

function scale(sprite::Sprite, factors::Vector2f)
	ccall((:sfSprite_scale, "libcsfml-graphics"), Void, (Ptr{Void}, Vector2f,), sprite.ptr, factors)
end

function set_texture(sprite::Sprite, texture::Texture)
	ccall((:sfSprite_setTexture, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Void}, Int32,), sprite.ptr, texture.ptr, 1)
end

function set_color(sprite::Sprite, color::Color)
	ccall((:sfSprite_setColor, "libcsfml-graphics"), Void, (Ptr{Void}, Color,), sprite.ptr, color)
end

function get_texture(sprite::Sprite)
	return Texture(ccall((sfSprite_getTexture, "libcsfml-graphics"), Ptr{Void}, (Ptr{Void},), sprite.ptr))
end

function get_color(sprite::Sprite)
	return ccall((:sfSprite_getColor, "libcsfml-graphics"), Color, (Ptr{Void},), sprite.ptr)
end

export get_color, get_texture, set_texture, scale, rotate, move, get_origin, get_rotation, get_position, set_origin, set_scale, set_rotation, set_position, copy, Sprite, destroy
