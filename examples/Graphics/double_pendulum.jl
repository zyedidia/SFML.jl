using SFML

t = 4*pi/4
a = 0*pi/8
td = 0.1 * rand()
ad = 0.2 * rand()
g = 9.8
delta = 1/60
torque = 0

# Setup the window with some anti aliasing
settings = ContextSettings()
settings.antialiasing_level = 3
window = RenderWindow(VideoMode(800, 600), "Double Pendulum", settings, window_defaultstyle)

# Framerate limit
set_framerate_limit(window, 60)
event = Event()
circles = CircleShape[]

# Create the three circles
for i = 1:3
    circle = CircleShape()
    set_radius(circle, 10)
    set_fillcolor(circle, SFML.red)
    set_origin(circle, Vector2f(10, 10))
    push!(circles, circle)
end
set_position(circles[3], Vector2f(400, 300))

# Create the two rectangles
rectangles = RectangleShape[]
for i = 1:2
    rect = RectangleShape()
    set_size(rect, Vector2f(10, 100))
    set_fillcolor(rect, SFML.blue)
    set_origin(rect, Vector2f(5, 0))
    push!(rectangles, rect)
end
set_position(rectangles[1], Vector2f(400, 300))

while isopen(window)
    # Check for events
    while pollevent(window, event)
        if get_type(event) == EventType.CLOSED
            close(window)
        end
        # Allow the user to control the torque with the left and right arrow keys
        if get_type(event) == EventType.KEY_PRESSED
            if get_key(event).key_code == KeyCode.LEFT
                torque = -1
            elseif get_key(event).key_code == KeyCode.RIGHT
                torque = 1
            end
        else
            torque = 0
        end
    end
    cycles = 2000
    # Simulate the physics
    for i = 1:cycles
        tdd = (1 / (2 - cos(a)*cos(a))) * (td*td*sin(a)*(1+cos(a)) + (2*td+ad)*ad*sin(a) + g*(cos(a)*sin(t+a)-2*sin(t)) - torque*(1 + cos(a)))
        add = -tdd - tdd*cos(a) - td*td*sin(a) - g*sin(t+a) + torque
        td += delta * tdd / cycles
        ad += delta * add / cycles
        t += delta * td / cycles
        a += delta * ad / cycles
    end
    x1 = 400 + 100 * sin(t)
    y1 = 300 + 100 * cos(t)
    x2 = 400 + 100 * (sin(t) + sin(a + t))
    y2 = 300 + 100 * (cos(t) + cos(a + t))
    # Set the positions of the circles and rectangles
    set_position(circles[1], Vector2f(x1, y1))
    set_position(circles[2], Vector2f(x2, y2))

    set_rotation(rectangles[1], -180*t/pi )
    set_rotation(rectangles[2], -180*(t+a)/pi )
    set_position(rectangles[2], Vector2f(x1, y1))

    # T = td*td + 0.5*(td+ad)^2 + td*(td+ad)*cos(a)
    # V = -g*(2*cos(t)+cos(t+a))
    # E = T+V
    # println(E)

    # Draw everything
    clear(window, SFML.black)
    for i = 1:length(rectangles)
        draw(window, rectangles[i])
    end
    for i = 1:length(circles)
        draw(window, circles[i])
    end
    display(window)
end
