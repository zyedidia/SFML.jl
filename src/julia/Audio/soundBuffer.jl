type SoundBuffer
	ptr::Ptr{Void}
end

function SoundBuffer(filename::ASCIIString)
	return SoundBuffer(ccall(dlsym(libcsfml_audio, :sfSoundBuffer_createFromFile), Ptr{Void}, (Ptr{Cchar},), pointer(filename)))
end

export SoundBuffer
