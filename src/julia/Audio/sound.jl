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
    Sound(ccall((:sfSound_create, libcsfml_audio), Ptr{Void}, ()))
end

function Sound(buffer::SoundBuffer)
    s = Sound()
    set_buffer(s, buffer)
    s
end

function copy(sound::Sound)
    return Sound(ccall((:sfSound_copy, libcsfml_audio), Ptr{Void}, (Ptr{Void},), sound.ptr))
end

function destroy(sound::Sound)
    ccall((:sfSound_destroy, libcsfml_audio), Void, (Ptr{Void},), sound.ptr)
end

function play(sound::Sound)
    ccall((:sfSound_play, libcsfml_audio), Void, (Ptr{Void},), sound.ptr)
end

function pause(sound::Sound)
    ccall((:sfSound_pause, libcsfml_audio), Void, (Ptr{Void},), sound.ptr)
end

function stop(sound::Sound)
    ccall((:sfSound_stop, libcsfml_audio), Void, (Ptr{Void},), sound.ptr)
end

function get_status(sound::Sound)
    ccall((:sfSound_getStatus, libcsfml_audio), Int32, (Ptr{Void},), sound.ptr)
end

function set_buffer(sound::Sound, sound_buffer::SoundBuffer)
    ccall((:sfSound_setBuffer, libcsfml_audio), Void, (Ptr{Void}, Ptr{Void},), sound.ptr, sound_buffer.ptr)
    sound.buffer = sound_buffer
end

function get_buffer(sound::Sound)
    return SoundBuffer(ccall((:sfSound_getBuffer, libcsfml_audio), Ptr{Void}, (Ptr{Void},), sound.ptr))
end

function set_loop(sound::Sound, loop::Bool)
    ccall((:sfSound_setLoop, libcsfml_audio), Void, (Ptr{Void}, Int32,), sound.ptr, loop)
end

function get_loop(sound::Sound)
    return Bool(ccall((:sfSound_getLoop, libcsfml_audio), Int32, (Ptr{Void},), sound.ptr))
end

function set_pitch(sound::Sound, pitch::Real)
    ccall((:sfSound_setPitch, libcsfml_audio), Void, (Ptr{Void}, Cfloat,), sound.ptr, pitch)
end

function get_pitch(sound::Sound)
    return Real(ccall((:sfSound_getPitch, libcsfml_audio), Cfloat, (Ptr{Void},), sound.ptr))
end

function set_volume(sound::Sound, volume::Real)
    ccall((:sfSound_setVolume, libcsfml_audio), Void, (Ptr{Void}, Cfloat,), sound.ptr, volume)
end

function get_volume(sound::Sound)
    return Real(ccall((:sfSound_getVolume, libcsfml_audio), Cfloat, (Ptr{Void},), sound.ptr))
end

function get_playing_offset(sound::Sound)
  return ccall((:sfSound_getPlayingOffset, libcsfml_audio), Time,
                    (Ptr{Void},), sound.ptr)
end

