using SFML

# Create the window
window = RenderWindow("Image and Texture Example", 800, 600)
# Set the framerate limit
set_framerate_limit(window, 60)
event = Event()

# Load the texture for the image
texture = Texture(joinpath(dirname(@__FILE__),"..","..","assets","sfmljl_logo.png"))
set_smooth(texture, true)
texture_size = get_size(texture)

# Create the logo sprite and add the texture to it
logo = Sprite()
set_texture(logo, texture)
set_position(logo, Vector2f(400, 300))
set_origin(logo, Vector2f(texture_size.x / 2, texture_size.y / 2))
# Scale it down a bit
scale(logo, Vector2f(0.3, 0.3))

while isopen(window)
    # Check for any events
    while pollevent(window, event)
        if get_type(event) == EventType.CLOSED
            close(window)
        end
    end

    # Rotate the sprite by 2 degrees
    rotate(logo, 2)

    # Clear the screen and redraw the sprite
    clear(window, SFML.white)
    draw(window, logo)
    display(window)
end
