using SFML

window = RenderWindow("Input Example", 800, 600)
set_framerate_limit(window, 60)
event = Event()

black = Color(0, 0, 0)

circle = CircleShape()
set_position(circle, Vector2f(50.0, 50.0))
set_radius(circle, 30)
set_fillcolor(circle, Color(255, 0, 0))

mousepos_text = Text()
font = Font("arial.ttf")
set_font(mousepos_text, font)
set_position(mousepos_text, Vector2f(250.0, 300.0))
set_string(mousepos_text, "Mouse Position: ")
set_color(mousepos_text, Color(255, 0, 0))
set_charactersize(mousepos_text, 25)

while isopen(window)
	while pollevent(window, event)
		if get_type(event) == EventType.CLOSE
			close(window)
		end
	end

	circle_position = get_position(circle)
	if (is_key_pressed(KeyCode.UP))
		circle_position.y -= 1
	elseif (is_key_pressed(KeyCode.DOWN))
		circle_position.y += 1
	end

	if (is_key_pressed(KeyCode.RIGHT))
		circle_position.x += 1
	elseif (is_key_pressed(KeyCode.LEFT))
		circle_position.x -= 1
	end

	set_position(circle, circle_position)

	if (is_mouse_pressed(MouseButton.LEFT))
		println("Left mouse button")
	end
	if (is_mouse_pressed(MouseButton.RIGHT))
		println("Right mouse button")
	end

	mousepos = get_mousepos(window)
	set_string(mousepos_text, "Mouse Position: $(mousepos.x) $(mousepos.y)")

	clear(window, black)
	draw(window, circle)
	draw(window, mousepos_text)
	display(window)
end
