type Thread
	ptr::Ptr{Void}
end

function Thread(callback::Function)
	callback_c = cfunction(callback, Void, ())
	ccall(dlsym(libjuliasfml, :runFunction), Void, (Ptr{Void}, Ptr{Void}, Int32,), callback_c, C_NULL, sizeof(callback_c))
end

# function destroy(thread::Thread)
# 	ccall(dlsym(libcsfml_system, :sfThread_destroy), Void, (Ptr{Void},), thread.ptr)
# 	thread = nothing
# end

# function launch(thread::Thread)
# 	ccall(dlsym(libcsfml_system, :sfThread_launch), Void, (Ptr{Void},), thread.ptr)
# end

function wait(thread::Thread)
	ccall(:pthread_join, Cint, (Uint64, Ptr{Void},), thread.ptr, C_NULL)
end

function terminate(thread::Thread)
	ccall(:pthread_exit, Void, (Uint64, Ptr{Void},), thread.ptr, C_NULL)
end

export Thread, destroy, launch, wait, terminate
