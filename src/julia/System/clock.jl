type Clock
	ptr::Ptr{Void}

	function Clock(ptr::Ptr{Void})
		c = new(ptr)
		finalizer(c, destroy)
		c
	end
end

function Clock()
	Clock(ccall((:sfClock_create, "libcsfml-system"), Ptr{Void}, ()))
end

function copy(clock::Clock)
	return Clock(ccall((:sfClock_copy, "libcsfml-system"), Ptr{Void}, (Ptr{Void},), clock.ptr))
end

function destroy(clock::Clock)
	ccall((:sfClock_destroy, "libcsfml-system"), Void, (Ptr{Void},), clock.ptr)
end

function get_elapsed_time(clock::Clock)
	return ccall((:sfClock_getElapsedTime, "libcsfml-system"), Time, (Ptr{Void},), clock.ptr)
end

function restart(clock::Clock)
	return ccall((:sfClock_restart, "libcsfml-system"), Time, (Ptr{Void},), clock.ptr)
end

export Clock, copy, get_elapsed_time, restart
