mutable struct Clock
    ptr::Ptr{Nothing}

    function Clock(ptr::Ptr{Nothing})
        c = new(ptr)
        finalizer(c, destroy)
        c
    end
end

function Clock()
    Clock(ccall((:sfClock_create, libcsfml_system), Ptr{Nothing}, ()))
end

function copy(clock::Clock)
    return Clock(ccall((:sfClock_copy, libcsfml_system), Ptr{Nothing}, (Ptr{Nothing},), clock.ptr))
end

function destroy(clock::Clock)
    ccall((:sfClock_destroy, libcsfml_system), Nothing, (Ptr{Nothing},), clock.ptr)
end

function get_elapsed_time(clock::Clock)
    return ccall((:sfClock_getElapsedTime, libcsfml_system), Time, (Ptr{Nothing},), clock.ptr)
end

function restart(clock::Clock)
    return ccall((:sfClock_restart, libcsfml_system), Time, (Ptr{Nothing},), clock.ptr)
end
