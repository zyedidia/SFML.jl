using SFML

window = RenderWindow("Sprite Example", 800, 600)
set_framerate_limit(window, 60)
event = Event()

black = Color(0, 0, 0)

sprite = Sprite()
texture = Texture("greenTank.png")

set_texture(sprite, texture)
set_position(sprite, Vector2f(50.0, 50.0))

while isopen(window)
	while pollevent(window, event)
		if get_type(event) == EventType.CLOSE
			close(window)
		end
	end

	clear(window, black)
	draw(window, sprite)
	display(window)
end
