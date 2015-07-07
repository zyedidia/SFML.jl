type SoundBuffer
    ptr::Ptr{Void}

    function SoundBuffer(ptr::Ptr{Void})
        s = new(ptr)
        # finalizer(s, destroy)
        # s
    end
end

function SoundBuffer(filename::String)
    SoundBuffer(ccall((:sfSoundBuffer_createFromFile, "libcsfml-audio"), Ptr{Void}, (Ptr{Cchar},), filename))
end

function copy(buffer::SoundBuffer)
    return SoundBuffer(ccall((:sfSoundBuffer_copy, "libcsfml-audio"), Ptr{Void}, (Ptr{Void},), buffer.ptr))
end

function destroy(buffer::SoundBuffer)
    ccall((:sfSoundBuffer_destroy, "libcsfml-audio"), Void, (Ptr{Void},), buffer.ptr)
end

function get_samplecount(buffer::SoundBuffer)
    ccall((:sfSoundBuffer_getSampleCount), Uint64, (Ptr{Void},), buffer.ptr)
end

function get_samples(buffer::SoundBuffer)
    pointer_to_array(ccall((:sfSoundBuffer_getSamples, "libcsfml-audio"), Ptr{Int16}, (Ptr{Void},), buffer.ptr), get_samplecount(buffer), true)
end

function get_samplerate(buffer::SoundBuffer)
    ccall((:sfSoundBuffer_getSampleRate, "libcsfml-audio"), Uint32, (Ptr{Void},), buffer.ptr)
end

function save_to_file(buffer::SoundBuffer, filename::String)
    ccall((:sfSoundBuffer_saveToFile, "libcsfml-audio"), Void, (Ptr{Void}, Ptr{Cchar},), buffer.ptr, filename)
end

function get_duration(buffer::SoundBuffer)
    return ccall((:sfSoundBUffer_getDuration, "libcsfml-audio"), Time, (Ptr{Void},), buffer.ptr)
end
