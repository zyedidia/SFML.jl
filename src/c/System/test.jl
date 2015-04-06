using SFML

function callback(arg)
	while true
		println("On other thread")
		sleep(1)
	end

	return Void
end

# t = Thread(callback)
# launch(t)

const callback_c = Base.SingleAsyncWork(data -> callback())
ccall(:uv_async_send, Cint, (Ptr{Void},), callback_c.handle)
# println(x)
# ccall((:runFunction, "libjuliasfml"), Void, (Ptr{Void},), x)
println(typeof(callback_c.cb))
ccall((:runFunction, "libjuliasfml"), Void, (Ptr{Void}, Ptr{Void},), callback_c, C_NULL)

while true
	println("On main thread")
	sleep(1)
end
