type Music
	ptr::Ptr{Void}
end

function Music(filename::ASCIIString)
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

export Music, destroy, set_loop, get_duration, get_loop, play, pause, stop
