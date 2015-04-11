using SFML

the_chicken = Music("TheChicken.ogg")

set_loop(the_chicken, true)
play(the_chicken)
playing = true

println("Press 'p' to pause and 'o' to resume")
println("Press escape to quit")

while true
	sleep(0.1)
	
	if is_key_pressed(KeyCode.ESCAPE)
		stop(the_chicken)
		destroy(the_chicken)
		exit(0)
	end

	if is_key_pressed(KeyCode.P)
		if !playing
			play(the_chicken)
		else
			pause(the_chicken)
		end
		playing = !playing
	end
end
