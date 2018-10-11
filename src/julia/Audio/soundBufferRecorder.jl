mutable struct SoundBufferRecorder
    ptr::Ptr{Nothing}

    function SoundBufferRecorder(ptr::Ptr{Nothing})
        s = new(ptr)
        # finalizer(s, destroy)
        # s
    end
end

function SoundBufferRecorder()
    SoundBufferRecorder(ccall((:sfSoundBufferRecorder_create, libcsfml_audio), Ptr{Nothing}, ()))
end

function destroy(recorder::SoundBufferRecorder)
    println("Destroy")
    ccall((:sfSoundBufferRecorder_destroy, libcsfml_audio), Nothing, (Ptr{Nothing},), recorder.ptr)
end

function start(recorder::SoundBufferRecorder, sample_rate::Integer = 44100)
    ccall((:sfSoundBufferRecorder_start, libcsfml_audio), Nothing, (Ptr{Nothing}, UInt32), recorder.ptr, sample_rate)
end

function stop(recorder::SoundBufferRecorder)
    ccall((:sfSoundBufferRecorder_stop, libcsfml_audio), Nothing, (Ptr{Nothing},), recorder.ptr)
end

function get_sample_rate(recorder::SoundBufferRecorder)
    return Int(ccall((:sfSoundBufferRecorder_getSampleRate, libcsfml_audio), UInt32, (Ptr{Nothing},), recorder.ptr))
end

function get_buffer(recorder::SoundBufferRecorder)
    return SoundBuffer(ccall((:sfSoundBufferRecorder_getBuffer, libcsfml_audio), Ptr{Nothing}, (Ptr{Nothing},), recorder.ptr))
end
