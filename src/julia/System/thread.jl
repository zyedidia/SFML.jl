type Thread
	ptr::Ptr{Void}
end

function Thread(callback::Function)
	callback_c = Base.SingleAsyncWork(data -> callback())

	async_send(func::Ptr{Void}) = (ccall(:uv_async_send, Cint, (Ptr{Void},), func); C_NULL)
	const c_async_send = cfunction(async_send, Ptr{Void}, (Ptr{Void},))

	# Thread(ccall(dlsym(libjuliasfml, :runThread), Ptr{Void}, (Ptr{Void}, Ptr{Void},), c_async_send, callback_c.handle))

	Thread(ccall(dlsym(libcsfml_system, :sfThread_create), Ptr{Void}, (Ptr{Void}, Ptr{Void},), c_async_send, callback_c.handle))
end

function destroy(thread::Thread)
	ccall(dlsym(libcsfml_system, :sfThread_destroy), Void, (Ptr{Void},), thread.ptr)
	thread = nothing
end

function launch(thread::Thread)
	ccall(dlsym(libcsfml_system, :sfThread_launch), Void, (Ptr{Void},), thread.ptr)
end

function wait(thread::Thread)
	println("Wait")
	ccall(dlsym(libcsfml_system, :sfThread_wait), Void, (Ptr{Void},), thread.ptr)
end

function terminate(thread::Thread)
	ccall(dlsym(libcsfml_system, :sfThread_terminate), Void, (Ptr{Void},), thread.ptr)
end

export Thread, destroy, launch, wait, terminate
