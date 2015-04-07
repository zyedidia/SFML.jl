type Clock
	ptr::Ptr{Void}
end

function Clock()
	return Clock(ccall(dlsym(libcsfml_system, :sfClock_create), Ptr{Void}, ()))
end

function copy(clock::Clock)
	return Clock(ccall(dlsym(libcsfml_system, :sfClock_copy), Ptr{Void}, (Ptr{Void},), clock.ptr))
end

function destroy(clock::Clock)
	ccall(dlsym(libcsfml_system, :sfClock_destroy), Void, (Ptr{Void},), clock.ptr)
	clock = nothing
end

function get_elapsed_time(clock::Clock)
	return ccall(dlsym(libcsfml_system, :sfClock_getElapsedTime), Time, (Ptr{Void},), clock.ptr)
end

function restart(clock::Clock)
	return ccall(dlsym(libcsfml_system, :sfClock_restart), Time, (Ptr{Void},), clock.ptr)
end

export Clock, copy, destroy, get_elapsed_time, restart
