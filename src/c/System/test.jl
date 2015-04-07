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

# t1 = Thread(thread1)
# t2 = Thread(thread2)



# ccall(:pthread_create, Cint, (Ptr{Void}, Ptr{Void}, Ptr{Void}, Ptr{Void},), thread, C_NULL, c_async_send_pthread, callback_c.handle)
# ccall(:pthread_join, Cint, (Uint64, Ptr{Void},), thread[1], C_NULL)
# ccall(:pthread_exit, Cint, (Uint64, Ptr{Void},), thread[1], C_NULL)

@parallel for i = 1:10
	println("On main thread")
	sleep(1)
end

# listener = TcpListener()
# listen(listener, 5400)

while true
end
# client = accept(listener)
