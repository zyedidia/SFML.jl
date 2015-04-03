using SFML

window = RenderWindow("Sprite Example", 800, 600)
set_framerate_limit(window, 60)
event = Event()

white = Color(255, 255, 255)

tank = Sprite()
texture = Texture("greenTank.png")
texture_size = get_size(texture)

set_texture(tank, texture)
set_position(tank, Vector2f(200.0, 300.0))
set_origin(tank, Vector2f(texture_size.x / 2, texture_size.y / 2))

while isopen(window)
	while pollevent(window, event)
		if get_type(event) == EventType.CLOSE
			close(window)
		end
	end

	rotate(tank, 2)

	clear(window, white)
	draw(window, tank)
	display(window)
end
