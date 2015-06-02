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

shader = ShaderFromMemory("", frag)
set_parameter(shader, "blur_radius", 0.01)

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
