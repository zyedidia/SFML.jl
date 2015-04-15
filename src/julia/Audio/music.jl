type Music
	ptr::Ptr{Void}
end

function Music(filename::String)
	return Music(ccall(dlsym(libcsfml_audio, :sfMusic_createFromFile), Ptr{Void}, (Ptr{Cchar},), pointer(filename)))
end

function destroy(music::Music)
	ccall(dlsym(libcsfml_audio, :sfMusic_destroy), Void, (Ptr{Void},), music.ptr)
	music = nothing
end

function set_loop(music::Music, loop::Bool)
	ccall(dlsym(libcsfml_audio, :sfMusic_setLoop), Void, (Ptr{Void}, Int32,), music.ptr, loop)
end

function get_loop(music::Music)
	return Bool(ccall(dlsym(libcsfml_audio, :sfMusic_getLoop), Int32, (Ptr{Void},), music.ptr))
end

function play(music::Music)
	ccall(dlsym(libcsfml_audio, :sfMusic_play), Void, (Ptr{Void},), music.ptr)
end

function pause(music::Music)
	ccall(dlsym(libcsfml_audio, :sfMusic_pause), Void, (Ptr{Void},), music.ptr)
end

function stop(music::Music)
	ccall(dlsym(libcsfml_audio, :sfMusic_pause), Void, (Ptr{Void},), music.ptr)
end

function get_duration(music::Music)
	return ccall(dlsym(libcsfml_audio, :sfMusic_getDuration), Time, (Ptr{Void},), music.ptr)
end

function get_channelcount(music::Music)
	return Real(ccall(dlsym(libcsfml_audio, :sfMusic_getChannelCount), Uint32, (Ptr{Void},), music.ptr))
end

function get_samplerate(music::Music)
	return Real(ccall(dlsym(libcsfml_audio, :sfMusic_getSampleRate), Uint32, (Ptr{Void},), music.ptr))
end

function set_pitch(music::Music, pitch::Real)
	ccall(dlsym(libcsfml_audio, :sfMusic_setPitch), Void, (Ptr{Void}, Cfloat,), music.ptr, pitch)
end

function set_volume(music::Music, volume::Real)
	ccall(dlsym(libcsfml_audio, :sfMusic_setVolume), Void, (Ptr{Void}, Cfloat,), music.ptr, volume)
end

function get_pitch(music::Music)
	return Real(ccall(dlsym(libcsfml_audio, :sfMusic_getPitch), Cfloat, (Ptr{Void},), music.ptr))
end

function get_volume(music::Music)
	return Real(ccall(dlsym(libcsfml_audio, :sfMusic_getVolume), Cfloat, (Ptr{Void},), music.ptr))
end

export Music, destroy, set_loop, get_duration, get_loop, play, pause, stop, get_channelcount, get_samplerate, 
set_pitch, set_volume, get_pitch, get_volume
