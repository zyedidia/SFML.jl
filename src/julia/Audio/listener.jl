function set_global_volume(volume::Real)
	ccall((:sfListener_setGlobalVolume, "libcsfml-audio"), Void, (Cfloat,), volume)
end

function get_global_volume()
	ccall((:sfListener_getGlobalVolume, "libcsfml-audio"), Cfloat, ())
end

function set_listener_position(pos::Vector3f)
	ccall((:sfListener_setPosition, "libcsfml-audio"), Void, (Vector3f,), pos)
end

function get_listener_position()
	ccall((:sfListener_getPosition, "libcsfml-audio"), Vector3f, ())
end

function set_listener_direction(direction::Vector3f)
	ccall((:sfListener_setDirection, "libcsfml-audio"), Void, (Vector3f,), direction)
end

function get_listener_direction(direction::Vector3f)
	ccall((:sfListener_getDirection, "libcsfml-audio"), Vector3f, ())
end

function set_listener_upvector(vect::Vector3f)
	ccall((:sfListener_setUpVector, "libcsfml-audio"), Void, (Vector3f,), vect)
end

function get_listener_upvector()
	ccall((:sfListener_getUpVector, "libcsfml-audio"), Vector3f, ())
end
