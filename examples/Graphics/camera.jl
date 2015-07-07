using SFML

# Create the window with a width of 800 and a height of 600
window = RenderWindow("Camera/Views", 800, 600)
# Always set the framerate limit
set_framerate_limit(window, 60)
# This is for listening for events
event = Event()

# Make a circle shape
circle = CircleShape()
# Do all the setup
set_radius(circle, 40)
set_position(circle, Vector2f(500, 200))
set_fillcolor(circle, SFML.red)

# Make a square
square = RectangleShape()
set_size(square, Vector2f(60, 60))
set_position(square, Vector2f(200, 400))
set_fillcolor(square, SFML.cyan)

# Cameras are views in SFML
# Pass it center of the view, and size of the view (same as window in this case)
view = View(Vector2f(400, 300), Vector2f(800, 600))

while isopen(window)
    # Check for any events
    while pollevent(window, event)
        if get_type(event) == EventType.CLOSED
            # Close the window if a closed event is detected
            close(window)
        end
    end

    # Check keypresses
    if is_key_pressed(KeyCode.LEFT)
        # Move left
        move(view, Vector2f(-0.5, 0))
    end
    if is_key_pressed(KeyCode.RIGHT)
        # Move right
        move(view, Vector2f(0.5, 0))
    end
    if is_key_pressed(KeyCode.UP)
        # Move up
        move(view, Vector2f(0, -0.5))
    end
    if is_key_pressed(KeyCode.DOWN)
        # Move down
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

    # Attach the view to the window
    set_view(window, view)

    # Clear and redraw the screen
    clear(window, SFML.white)
    draw(window, square)
    draw(window, circle)
    display(window)
end
