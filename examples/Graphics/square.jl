using SFML

window = RenderWindow("Square", 800, 600)
set_framerate_limit(window, 60)

event = Event()

black = Color(0, 0, 0)

square = RectangleShape()
set_size(square, Vector2f(40.0, 40.0))
set_position(square, Vector2f(400.0, 300.0))
set_origin(square, Vector2f(20.0, 20.0))
set_fillcolor(square, Color(255, 0, 0))

while isopen(window)
	while pollevent(window, event)
		if get_type(event) == EventType.CLOSE
			close(window)
		end
	end

	clear(window, black)
	draw(window, square)
	display(window)
end
