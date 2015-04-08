type SoundBuffer
	ptr::Ptr{Void}
end

function SoundBuffer(filename::ASCIIString)
	return SoundBuffer(ccall(dlsym(libjuliasfml, :sjSoundBuffer_createFromFile), Ptr{Void}, (Ptr{Cchar},), pointer(filename)))
end

export SoundBuffer
