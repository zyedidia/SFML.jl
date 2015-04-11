using SFML

i = 0

function callback()
	while true
		println("In callback")
		sleep(1)

		if (i == 2)
			println("Done")
			return nothing
		end
	end
end

function thread2()
	while true
		println("in thread 2")
		sleep(1)
	end
end

# const callback_c = Base.SingleAsyncWork(data -> callback())
# async_send_pthread(func::Ptr{Void}) = (ccall(:uv_async_send, Cint, (Ptr{Void},), func); C_NULL)
# const c_async_send_pthread = cfunction(async_send_pthread, Ptr{Void}, (Ptr{Void},))

# t = Thread(c_async_send_pthread, callback_c.handle)
t = Thread(callback)
launch(t)

# t2 = Thread(thread2)
# launch(t2)

while true
	println("test")
	sleep(1)

	i += 1
end
