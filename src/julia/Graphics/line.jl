type Line
	rect::RectangleShape
	p1::Vector2
	p2::Vector2
	thickness::Real
end

function Line(p1::Vector2, p2::Vector2, thickness::Real)
	rect = RectangleShape()
	set_position(rect, to_vec2f(p1))
	set_size(rect, Vector2f(distance(p1, p2), thickness))
	set_rotation(rect, rad2deg(atan2(p2.y - p1.y, p2.x - p1.x)))
	set_origin(rect, Vector2f(0, thickness / 2))

	Line(rect, p1, p2, thickness)
end

function copy(l::Line)
	Line(l.p1, l.p2, l.thickness)
end

function set_fillcolor(l::Line, c::Color)
	set_fillcolor(l.rect, c)
end

function get_fillcolor(l::Line)
	return get_fillcolor(l.rect)
end

function set_outlinecolor(l::Line, c::Color)
	set_outlinecolor(l.rect, c)
end

function get_outlinecolor(l::Line)
	return get_outlinecolor(l.rect)
end

function set_outline_thickness(l::Line, thickness::Real)
	set_outline_thickness(l.rect, thickness)
end

function get_outline_thickness(l::Line)
	return get_outline_thickness(l.rect)
end

function draw(window::RenderWindow, object::Line)
	draw(window, object.rect)
end

function draw(texture::RenderTexture, object::Line)
	draw(texture, object.rect)
end

export Line, set_fillcolor, get_fillcolor, set_outlinecolor, get_outlinecolor,
set_outline_thickness, get_outline_thickness, copy, draw
