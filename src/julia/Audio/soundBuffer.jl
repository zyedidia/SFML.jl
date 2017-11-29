type SoundBuffer
    ptr::Ptr{Void}

    function SoundBuffer(ptr::Ptr{Void})
        s = new(ptr)
        # finalizer(s, destroy)
        # s
    end
end

function SoundBuffer(filename::AbstractString)
    SoundBuffer(ccall((:sfSoundBuffer_createFromFile, libcsfml_audio), Ptr{Void}, (Ptr{Cchar},), filename))
end

function SoundBuffer(buffer::Array{Int16},samplerate::Int)
  SoundBuffer(ccall((:sfSoundBuffer_createFromSamples, libcsfml_audio),
                    Ptr{Void}, (Ptr{Int16}, UInt64, UInt, UInt),
                    buffer,size(buffer,1),size(buffer,2),samplerate))
end

function copy(buffer::SoundBuffer)
    return SoundBuffer(ccall((:sfSoundBuffer_copy, libcsfml_audio), Ptr{Void}, (Ptr{Void},), buffer.ptr))
end

function destroy(buffer::SoundBuffer)
    ccall((:sfSoundBuffer_destroy, libcsfml_audio), Void, (Ptr{Void},), buffer.ptr)
end

function get_samplecount(buffer::SoundBuffer)
    ccall((:sfSoundBuffer_getSampleCount), UInt64, (Ptr{Void},), buffer.ptr)
end

function get_samples(buffer::SoundBuffer)
    ptr = ccall((:sfSoundBuffer_getSamples, libcsfml_audio), Ptr{Int16}, (Ptr{Void},), buffer.ptr)
    @compat unsafe_wrap(Vector{Int16}, ptr, get_samplecount(buffer), true)
end

function get_samplerate(buffer::SoundBuffer)
    ccall((:sfSoundBuffer_getSampleRate, libcsfml_audio), UInt32, (Ptr{Void},), buffer.ptr)
end

function save_to_file(buffer::SoundBuffer, filename::AbstractString)
    ccall((:sfSoundBuffer_saveToFile, libcsfml_audio), Void, (Ptr{Void}, Ptr{Cchar},), buffer.ptr, filename)
end

function get_duration(buffer::SoundBuffer)
    return ccall((:sfSoundBuffer_getDuration, libcsfml_audio), Time, (Ptr{Void},), buffer.ptr)
end
