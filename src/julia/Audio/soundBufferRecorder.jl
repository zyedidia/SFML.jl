type SoundBufferRecorder
    ptr::Ptr{Void}

    function SoundBufferRecorder(ptr::Ptr{Void})
        s = new(ptr)
        # finalizer(s, destroy)
        # s
    end
end

function SoundBufferRecorder()
    SoundBufferRecorder(ccall((:sfSoundBufferRecorder_create, libcsfml_audio), Ptr{Void}, ()))
end

function destroy(recorder::SoundBufferRecorder)
    println("Destroy")
    ccall((:sfSoundBufferRecorder_destroy, libcsfml_audio), Void, (Ptr{Void},), recorder.ptr)
end

function start(recorder::SoundBufferRecorder, sample_rate::Integer = 44100)
    ccall((:sfSoundBufferRecorder_start, libcsfml_audio), Void, (Ptr{Void}, UInt32), recorder.ptr, sample_rate)
end

function stop(recorder::SoundBufferRecorder)
    ccall((:sfSoundBufferRecorder_stop, libcsfml_audio), Void, (Ptr{Void},), recorder.ptr)
end

function get_sample_rate(recorder::SoundBufferRecorder)
    return Int(ccall((:sfSoundBufferRecorder_getSampleRate, libcsfml_audio), UInt32, (Ptr{Void},), recorder.ptr))
end

function get_buffer(recorder::SoundBufferRecorder)
    return SoundBuffer(ccall((:sfSoundBufferRecorder_getBuffer, libcsfml_audio), Ptr{Void}, (Ptr{Void},), recorder.ptr))
end
