using SFML

window = RenderWindow(VideoMode(800, 600), "Square", window_defaultstyle)
set_framerate_limit(window, 60)

event = Event()

square = RectangleShape()
set_size(square, Vector2f(40, 40))
set_position(square, Vector2f(400, 300))
set_origin(square, Vector2f(20, 20))
set_fillcolor(square, SFML.magenta)
set_outlinecolor(square, Color(4, 200, 127))
set_outline_thickness(square, 2)

while isopen(window)
    while pollevent(window, event)
        if get_type(event) == EventType.CLOSED
            close(window)
        end
    end
    clear(window, SFML.white)
    draw(window, square)
    display(window)
end
