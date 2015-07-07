using SFML

window = RenderWindow("RenderText example", 800, 600)
set_framerate_limit(window, 60)

event = Event()

text = RenderText()
set_position(text, Vector2f(400.0, 300.0))
set_string(text, "SFML.jl is cool")
set_style(text, TextBold | TextUnderlined | TextItalic | TextStrikeThrough)
set_color(text, SFML.cyan)
set_charactersize(text, 50)
text_size = get_globalbounds(text)
set_origin(text, Vector2f(text_size.width / 2, text_size.height / 2))

println(get_string(text))

while isopen(window)
    while pollevent(window, event)
        if get_type(event) == EventType.CLOSED
            close(window)
        end
    end

    clear(window, SFML.black)
    draw(window, text)
    display(window)
end
