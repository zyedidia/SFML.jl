using SFML

# This program draws the SFML.jl logo and applies a blur shader to it

window = RenderWindow("Shader Test", 800, 600)

event = Event()

texture = Texture(joinpath(dirname(@__FILE__),"..","..","assets","sfmljl_logo.png"))
sprite = Sprite()
set_texture(sprite, texture)
set_position(sprite, Vector2f(400, 300))
scale(sprite, Vector2f(0.25, 0.25))
size = get_size(texture)
set_origin(sprite, Vector2f(size.x/2, size.y/2))

vert =
"""
uniform float wave_phase;
uniform vec2 wave_amplitude;

void main()
{
    vec4 vertex = gl_Vertex;
    vertex.x += cos(gl_Vertex.y * 0.02 + wave_phase * 3.8) * wave_amplitude.x
              + sin(gl_Vertex.y * 0.02 + wave_phase * 6.3) * wave_amplitude.x * 0.3;
    vertex.y += sin(gl_Vertex.x * 0.02 + wave_phase * 2.4) * wave_amplitude.y
              + cos(gl_Vertex.x * 0.02 + wave_phase * 5.2) * wave_amplitude.y * 0.3;

    gl_Position = gl_ModelViewProjectionMatrix * vertex;
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
    gl_FrontColor = gl_Color;
}
"""

frag =
"""
uniform sampler2D texture;
uniform float blur_radius;

void main()
{
    vec2 offx = vec2(blur_radius, 0.0);
    vec2 offy = vec2(0.0, blur_radius);

    vec4 pixel = texture2D(texture, gl_TexCoord[0].xy)               * 4.0 +
                 texture2D(texture, gl_TexCoord[0].xy - offx)        * 2.0 +
                 texture2D(texture, gl_TexCoord[0].xy + offx)        * 2.0 +
                 texture2D(texture, gl_TexCoord[0].xy - offy)        * 2.0 +
                 texture2D(texture, gl_TexCoord[0].xy + offy)        * 2.0 +
                 texture2D(texture, gl_TexCoord[0].xy - offx - offy) * 1.0 +
                 texture2D(texture, gl_TexCoord[0].xy - offx + offy) * 1.0 +
                 texture2D(texture, gl_TexCoord[0].xy + offx - offy) * 1.0 +
                 texture2D(texture, gl_TexCoord[0].xy + offx + offy) * 1.0;

    gl_FragColor =  gl_Color * (pixel / 16.0);
}
"""

shader = ShaderFromMemory(vert, frag)
set_parameter(shader, "texture")

state = RenderStates(shader)

clock = Clock()

while isopen(window)
    while pollevent(window, event)
        if get_type(event) == EventType.CLOSED
            close(window)
        end
    end

    x = get_mousepos(window).x / get_size(window).x
    y = get_mousepos(window).y / get_size(window).y

    set_parameter(shader, "blur_radius", (x + y) * 0.008)
    set_parameter(shader, "wave_phase", get_elapsed_time(clock) |> as_seconds)
    set_parameter(shader, "wave_amplitude", Vector2f(x * 40, y * 40))

    clear(window, SFML.black)
    draw(window, sprite, state)
    display(window)
end
