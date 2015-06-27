type SoundBufferRecorder
	ptr::Ptr{Void}

	function SoundBufferRecorder(ptr::Ptr{Void})
		s = new(ptr)
		# finalizer(s, destroy)
		# s
	end
end

function SoundBufferRecorder()
	SoundBufferRecorder(ccall((:sfSoundBufferRecorder_create, "libcsfml-audio"), Ptr{Void}, ()))
end

function destroy(recorder::SoundBufferRecorder)
	println("Destroy")
	ccall((:sfSoundBufferRecorder_destroy, "libcsfml-audio"), Void, (Ptr{Void},), recorder.ptr)
end

function start(recorder::SoundBufferRecorder, sample_rate::Integer = 44100)
	ccall((:sfSoundBufferRecorder_start, "libcsfml-audio"), Void, (Ptr{Void}, Uint32), recorder.ptr, sample_rate)
end

function stop(recorder::SoundBufferRecorder)
	ccall((:sfSoundBufferRecorder_stop, "libcsfml-audio"), Void, (Ptr{Void},), recorder.ptr)
end

function get_sample_rate(recorder::SoundBufferRecorder)
	return Int(ccall((:sfSoundBufferRecorder_getSampleRate, "libcsfml-audio"), Uint32, (Ptr{Void},), recorder.ptr))
end

function get_buffer(recorder::SoundBufferRecorder)
	return SoundBuffer(ccall((:sfSoundBufferRecorder_getBuffer, "libcsfml-audio"), Ptr{Void}, (Ptr{Void},), recorder.ptr))
end
