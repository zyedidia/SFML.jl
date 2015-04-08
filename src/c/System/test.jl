using SFML

function thread1()
	while true
		println("On thread 1")
		sleep(1)
	end

	return Void
end
function thread2()
	while true
		println("On thread 2")
		sleep(1)
	end

	return Void
end

const callback_c = Base.SingleAsyncWork(data -> thread1())
async_send_pthread(func::Ptr{Void}) = (ccall(:uv_async_send, Cint, (Ptr{Void},), func); C_NULL)
const c_async_send_pthread = cfunction(async_send_pthread, Ptr{Void}, (Ptr{Void},))

thread = Uint64[0]
# thread2 = Uint64[0]

ccall(:pthread_create, Cint, (Ptr{Void}, Ptr{Void}, Ptr{Void}, Ptr{Void},), thread, C_NULL, c_async_send_pthread, callback_c.handle)
ccall(:pthread_join, Cint, (Uint64, Ptr{Void},), thread[1], C_NULL)
# ccall(:pthread_exit, Cint, (Uint64, Ptr{Void},), thread[1], C_NULL)

while true
	println("On main thread")
	sleep(1)
end
