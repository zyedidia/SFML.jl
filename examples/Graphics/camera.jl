using SFML

window = RenderWindow("Camera/Views", 800, 600)
event = Event()

circle = CircleShape()
set_radius(circle, 40)
set_position(circle, Vector2f(500, 200))
set_fillcolor(circle, SFML.red)

square = RectangleShape()
set_size(square, Vector2f(60, 60))
set_position(square, Vector2f(200, 400))
set_fillcolor(square, SFML.cyan)

# Cameras are views in SFML
# Pass it center of the view, and size of the view (same as window in this case)
view = View(Vector2f(400, 300), Vector2f(800, 600))

while isopen(window)
	while pollevent(window, event)
		if get_type(event) == EventType.CLOSED
			close(window)
		end
	end

	if is_key_pressed(KeyCode.LEFT)
		move(view, Vector2f(-0.5, 0))
	end
	if is_key_pressed(KeyCode.RIGHT)
		move(view, Vector2f(0.5, 0))
	end
	if is_key_pressed(KeyCode.UP)
		move(view, Vector2f(0, -0.5))
	end
	if is_key_pressed(KeyCode.DOWN)
		move(view, Vector2f(0, 0.5))
	end
	# Zoom out
	if is_key_pressed(KeyCode.Z)
		zoom(view, 0.5)
		set_size(view, Vector2f(1600, 1200))
	end
	# Zoom in
	if is_key_pressed(KeyCode.X)
		zoom(view, 1.5)
		set_size(view, Vector2f(400, 300))
	end

	set_view(window, view)

	clear(window, SFML.white)
	draw(window, square)
	draw(window, circle)
	display(window)
end
