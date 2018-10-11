using SFML

function thread1()
    while true
        println("In thread1")
        sleep(1)
    end
end

function thread2()
    while true
        println("In thread 2")
        sleep(1)
    end
end

# const callback_c = Base.SingleAsyncWork(data -> thread1())
# async_send_pthread(func::Ptr{Nothing}) = (ccall(:uv_async_send, Cint, (Ptr{Nothing},), func); C_NULL)
# const c_async_send_pthread = cfunction(async_send_pthread, Ptr{Nothing}, (Ptr{Nothing},))

# t = Thread(c_async_send_pthread, callback_c.handle)
t = Thread(thread1)
launch(t)

# SFML.wait(t)

t2 = Thread(thread2)
launch(t2)

while true
    println("Main thread")
    sleep(1)
end
