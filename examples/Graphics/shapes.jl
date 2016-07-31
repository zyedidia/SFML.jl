using SFML

window = RenderWindow("Shapes", 800, 600)
event = Event()

texture = Texture(joinpath(dirname(@__FILE__),"wood-texture.jpg"))

triangle = CircleShape()
set_radius(triangle, 100)
set_pointcount(triangle, 3)
set_position(triangle, Vector2f(400, 300))
set_texture(triangle, texture)

convex_shape = ConvexShape()
set_pointcount(convex_shape, 5)
set_point(convex_shape, 0, Vector2f(0, 0))
set_point(convex_shape, 1, Vector2f(150, 10))
set_point(convex_shape, 2, Vector2f(120, 90))
set_point(convex_shape, 3, Vector2f(30, 100))
set_point(convex_shape, 4, Vector2f(0, 50))

set_position(convex_shape, Vector2f(100.0, 400.0))
set_fillcolor(convex_shape, SFML.green)
set_outlinecolor(convex_shape, SFML.red)
set_outline_thickness(convex_shape, 5)

more_points = true

clock = Clock()
restart(clock)

while isopen(window)
    while pollevent(window, event)
        if get_type(event) == EventType.CLOSED
            close(window)
        end
    end

    if as_seconds(get_elapsed_time(clock)) >= 0.75
        triangle_pointcount = get_pointcount(triangle)
        if triangle_pointcount > 8
            more_points = false
        elseif triangle_pointcount <= 3
            more_points = true
        end

        num = more_points ? 1 : -1
        set_pointcount(triangle, get_pointcount(triangle) + num)

        restart(clock)
    end

    clear(window, SFML.black)
    draw(window, triangle)
    draw(window, convex_shape)
    display(window)
end

