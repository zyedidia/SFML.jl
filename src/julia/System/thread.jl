type Thread
	ptr::Ptr{Void}
end

function Thread(callback::Function)
	const callback_c = cfunction(callback, Void, ())
	return Thread(ccall(dlsym(libcsfml_system, :sfThread_create), Ptr{Void}, (Ptr{Void}, Ptr{Void},), callback_c, C_NULL))
end

function destroy(thread::Thread)
	ccall(dlsym(libcsfml_system, :sfThread_destroy), Void, (Ptr{Void},), thread.ptr)
	thread = nothing
end

function launch(thread::Thread)
	ccall(dlsym(libcsfml_system, :sfThread_launch), Void, (Ptr{Void},), thread.ptr)
end

function wait(thread::Thread)
	ccall(dlsym(libcsfml_system, :sfThread_wait), Void, (Ptr{Void},), thread.ptr)
end

function terminate(thread::Thread)
	ccall(dlsym(libcsfml_system, :sfThread_terminate), Void, (Ptr{Void},), thread.ptr)
end

export Thread, destroy, launch, wait, terminate
