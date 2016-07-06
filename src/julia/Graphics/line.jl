type Line
    rect::RectangleShape
end

function Line(p1::Vector2, p2::Vector2, thickness::Real=2)
    rect = RectangleShape()
    set_position(rect, to_vec2f(p1))
    set_size(rect, Vector2f(distance(p1, p2), thickness))
    set_rotation(rect, rad2deg(atan2(p2.y - p1.y, p2.x - p1.x)))
    set_origin(rect, Vector2f(0, thickness / 2))

    Line(rect)
end

function copy(l::Line)
    Line(l.p1, l.p2, l.thickness)
end

function set_points(l::Line, p1::Vector2, p2::Vector2)
    set_position(l.rect, to_vec2f(p1))
    set_rotation(l.rect, rad2deg(atan2(p2.y - p1.y, p2.x - p1.x)))
    set_size(l.rect, Vector2f(distance(p1, p2), get_thickness(l)))
end

function get_points(l::Line)
    pos = get_position(l.rect)
    rot = get_rotation(l.rect)
    len = get_size(l.rect).x

    p2 = Vector2f(pos.x + len*cosd(rot), pos.y + len*sind(rot))
    pos, p2
end

function set_thickness(l::Line, thickness::Real)
    p1, p2 = get_points(l)
    set_size(l.rect, Vector2f(distance(p1, p2), thickness))
    set_origin(l.rect, Vector2f(0, thickness / 2))
end

function get_thickness(l::Line)
    get_size(l.rect).y
end

function set_fillcolor(l::Line, c::Color)
    set_fillcolor(l.rect, c)
end

function get_fillcolor(l::Line)
    get_fillcolor(l.rect)
end

function set_outlinecolor(l::Line, c::Color)
    set_outlinecolor(l.rect, c)
end

function get_outlinecolor(l::Line)
    get_outlinecolor(l.rect)
end

function set_outline_thickness(l::Line, thickness::Real)
    set_outline_thickness(l.rect, thickness)
end

function get_outline_thickness(l::Line)
    get_outline_thickness(l.rect)
end

function draw(window::RenderWindow, object::Line)
    draw(window, object.rect)
end

function draw(texture::RenderTexture, object::Line)
    draw(texture, object.rect)
end
