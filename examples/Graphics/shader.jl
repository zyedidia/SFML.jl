using SFML

# This program draws the SFML.jl logo and applies a blur shader to it

window = RenderWindow("Shader Test", 800, 600)

event = Event()

texture = Texture(Pkg.dir("SFML")*"/assets/sfmljl_logo.png")
sprite = Sprite()
set_texture(sprite, texture)
set_position(sprite, Vector2f(400, 300))
scale(sprite, Vector2f(0.25, 0.25))
size = get_size(texture)
set_origin(sprite, Vector2f(size.x/2, size.y/2))

frag =
"""
uniform sampler2D texture;
uniform float pixel_threshold;

void main()
{
    float factor = 1.0 / (pixel_threshold + 0.001);
    vec2 pos = floor(gl_TexCoord[0].xy * factor + 0.5) / factor;
    gl_FragColor = texture2D(texture, pos) * gl_Color;
}
"""

shader = ShaderFromMemory("", frag)
set_parameter(shader, "pixel_threshold", 0.01)
set_parameter(shader, "texture")

state = RenderStates(shader)

while isopen(window)
	while pollevent(window, event)
		if get_type(event) == EventType.CLOSED
			close(window)
		end
	end

	clear(window, SFML.black)
	draw(window, sprite, state)
	display(window)
end
