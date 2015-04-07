type Thread
	ptr::Uint64
end

function Thread(callback::Function)
	threads = Uint64[0]
	const callback_c = Base.SingleAsyncWork(data -> callback())
	async_send_pthread(func::Ptr{Void}) = (ccall(:uv_async_send, Cint, (Ptr{Void},), func); C_NULL)
	const c_async_send_pthread = cfunction(async_send_pthread, Ptr{Void}, (Ptr{Void},))
	ccall(:pthread_create, Cint, (Ptr{Void}, Ptr{Void}, Ptr{Void}, Ptr{Void},), threads, C_NULL, c_async_send_pthread, callback_c.handle)
	return Thread(threads[1])
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
