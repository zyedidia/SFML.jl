using SFML

window = RenderWindow("Text example", 800, 600)
set_framerate_limit(window, 60)

event = Event()

white = Color(255, 255, 255)

text = Text()
set_position(text, Vector2f(400.0, 600.0))
set_string(text, "SFML.jl is cool")
set_color(text, Color(255, 0, 0))

while isopen(window)
	while pollevent(window, event)
		if get_type(event) == EventType.CLOSE
			close(window)
		end
	end

	clear(window, white)
	draw(window, text)
	display(window)
end
