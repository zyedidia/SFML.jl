mutable struct SoundBuffer
    ptr::Ptr{Nothing}

    function SoundBuffer(ptr::Ptr{Nothing})
        s = new(ptr)
        # finalizer(s, destroy)
        # s
    end
end

function SoundBuffer(filename::AbstractString)
    SoundBuffer(ccall((:sfSoundBuffer_createFromFile, libcsfml_audio), Ptr{Nothing}, (Ptr{Cchar},), filename))
end

function SoundBuffer(buffer::Array{Int16},samplerate::Int)
  SoundBuffer(ccall((:sfSoundBuffer_createFromSamples, libcsfml_audio),
                    Ptr{Nothing}, (Ptr{Int16}, UInt64, UInt, UInt),
                    buffer,size(buffer,1),size(buffer,2),samplerate))
end

function copy(buffer::SoundBuffer)
    return SoundBuffer(ccall((:sfSoundBuffer_copy, libcsfml_audio), Ptr{Nothing}, (Ptr{Nothing},), buffer.ptr))
end

function destroy(buffer::SoundBuffer)
    ccall((:sfSoundBuffer_destroy, libcsfml_audio), Nothing, (Ptr{Nothing},), buffer.ptr)
end

function get_samplecount(buffer::SoundBuffer)
    ccall((:sfSoundBuffer_getSampleCount), UInt64, (Ptr{Nothing},), buffer.ptr)
end

function get_samples(buffer::SoundBuffer)
    ptr = ccall((:sfSoundBuffer_getSamples, libcsfml_audio), Ptr{Int16}, (Ptr{Nothing},), buffer.ptr)
    @compat unsafe_wrap(Vector{Int16}, ptr, get_samplecount(buffer), true)
end

function get_samplerate(buffer::SoundBuffer)
    ccall((:sfSoundBuffer_getSampleRate, libcsfml_audio), UInt32, (Ptr{Nothing},), buffer.ptr)
end

function save_to_file(buffer::SoundBuffer, filename::AbstractString)
    ccall((:sfSoundBuffer_saveToFile, libcsfml_audio), Nothing, (Ptr{Nothing}, Ptr{Cchar},), buffer.ptr, filename)
end

function get_duration(buffer::SoundBuffer)
    return ccall((:sfSoundBuffer_getDuration, libcsfml_audio), Time, (Ptr{Nothing},), buffer.ptr)
end
