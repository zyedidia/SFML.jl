using SFML

window = RenderWindow("Image and Texture Example", 800, 600)
set_framerate_limit(window, 60)
event = Event()

logo = Sprite()
texture = Texture(Pkg.dir("SFML")*"/assets/sfmljl_logo.png")
set_smooth(texture, true)
texture_size = get_size(texture)
set_smooth(texture, true)

set_texture(logo, texture)
set_position(logo, Vector2f(400, 300))
set_origin(logo, Vector2f(texture_size.x / 2, texture_size.y / 2))
scale(logo, Vector2f(0.3, 0.3))

while isopen(window)
	while pollevent(window, event)
		if get_type(event) == EventType.CLOSED
			close(window)
		end
	end

	rotate(logo, 2)

	clear(window, SFML.white)
	draw(window, logo)
	display(window)
end
