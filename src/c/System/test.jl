using SFML

function thread1()
	while true
		println("On thread1")
		sleep(1)
	end

	return Void
end

function thread2()
	while true
		println("On thread2")
		sleep(1)
	end
end

t = Thread(thread1)
println(t)

t2 = Thread(thread2)
println(t2)

sleep(5)
println("Cancelling thread1")
terminate(t)
sleep(5)
println("Cancelling thread2")
terminate(t2)

while true
	println("Main thread")
	sleep(1)
end
