type SoundBufferRecorder
	ptr::Ptr{Void}
end

function SoundBufferRecorder()
	return SoundBufferRecorder(ccall(dlsym(libcsfml_audio, :sfSoundBufferRecorder_create), Ptr{Void}, ()))
end

function destroy(recorder::SoundBufferRecorder)
	ccall(dlsym(libcsfml_audio, :sfSoundBufferRecorder_destroy), Void, (Ptr{Void},), recorder.ptr)
	recorder = nothing
end

function start(recorder::SoundBufferRecorder, sample_rate::Integer = 44100)
	ccall(dlsym(libcsfml_audio, :sfSoundBufferRecorder_start), Void, (Ptr{Void}, Uint32), recorder.ptr, sample_rate)
end

function stop(recorder::SoundBufferRecorder)
	ccall(dlsym(libcsfml_audio, :sfSoundBufferRecorder_stop), Void, (Ptr{Void},), recorder.ptr)
end

function get_sample_rate(recorder::SoundBufferRecorder)
	return Int(ccall(dlsym(libcsfml_audio, :sfSoundBufferRecorder_getSampleRate), Uint32, (Ptr{Void},), recorder.ptr))
end

function get_buffer(recorder::SoundBufferRecorder)
	return SoundBuffer(ccall(dlsym(libcsfml_audio, :sfSoundBufferRecorder_getBuffer), Ptr{Void}, (Ptr{Void},), recorder.ptr))
end

export SoundBufferRecorder, destroy, start, stop, get_sample_rate, get_buffer
