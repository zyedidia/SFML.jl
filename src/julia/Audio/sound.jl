type Sound
    ptr::Ptr{Void}
    buffer

    function Sound(ptr::Ptr{Void})
        s = new(ptr, nothing)
        finalizer(s, destroy)
        s
    end
end

function Sound()
    Sound(ccall((:sfSound_create, "libcsfml-audio"), Ptr{Void}, ()))
end

function Sound(buffer::SoundBuffer)
    s = Sound()
    set_buffer(s, buffer)
    s
end

function copy(sound::Sound)
    return Sound(ccall((:sfSound_copy, "libcsfml-audio"), Ptr{Void}, (Ptr{Void},), sound.ptr))
end

function destroy(sound::Sound)
    ccall((:sfSound_destroy, "libcsfml-audio"), Void, (Ptr{Void},), sound.ptr)
end

function play(sound::Sound)
    ccall((:sfSound_play, "libcsfml-audio"), Void, (Ptr{Void},), sound.ptr)
end

function pause(sound::Sound)
    ccall((:sfSound_pause, "libcsfml-audio"), Void, (Ptr{Void},), sound.ptr)
end

function stop(sound::Sound)
    ccall((:sfSound_stop, "libcsfml-audio"), Void, (Ptr{Void},), sound.ptr)
end

function get_status(sound::Sound)
    ccall((:sfSound_getStatus, "libcsfml-audio"), Int32, (Ptr{Void},), sound.ptr)
end

function set_buffer(sound::Sound, sound_buffer::SoundBuffer)
    ccall((:sfSound_setBuffer, "libcsfml-audio"), Void, (Ptr{Void}, Ptr{Void},), sound.ptr, sound_buffer.ptr)
    sound.buffer = sound_buffer
end

function get_buffer(sound::Sound)
    return SoundBuffer(ccall((:sfSound_getBuffer, "libcsfml-audio"), Void, (Ptr{Void},), sound.ptr))
end

function set_loop(sound::Sound, loop::Bool)
    ccall((:sfSound_setLoop, "libcsfml-audio"), Void, (Ptr{Void}, Int32,), sound.ptr, loop)
end

function get_loop(sound::Sound)
    return Bool(ccall((:sfSound_getLoop, "libcsfml-audio"), Int32, (Ptr{Void},), sound.ptr))
end

function set_pitch(sound::Sound, pitch::Real)
    ccall((:sfSound_setPitch, "libcsfml-audio"), Void, (Ptr{Void}, Cfloat,), sound.ptr, pitch)
end

function get_pitch(sound::Sound)
    return Real(ccall((:sfSound_getPitch, "libcsfml-audio"), Cfloat, (Ptr{Void},), sound.ptr))
end

function set_volume(sound::Sound, volume::Real)
    ccall((:sfSound_setVolume, "libcsfml-audio"), Void, (Ptr{Void}, Cfloat,), sound.ptr, volume)
end

function get_volume(sound::Sound)
    return Real(ccall((:sfSound_getVolume, "libcsfml-audio"), Cfloat, (Ptr{Void},), sound.ptr))
end
