type Color
	r::Uint8
	g::Uint8
	b::Uint8
	a::Uint8

	function Color(r::Integer, g::Integer, b::Integer)
		clamp(r, 0, 255); clamp(g, 0, 255); clamp(b, 0, 255);
		new(Uint8(r), Uint8(g), Uint8(b), Uint8(255))
	end

	function Color(r::Integer, g::Integer, b::Integer, a::Integer)
		clamp(r, 0, 255); clamp(g, 0, 255); clamp(b, 0, 255); clamp(a, 0, 255)
		new(Uint8(r), Uint8(g), Uint8(b), Uint8(a))
	end
end

const BLACK = Color(0, 0, 0)
const WHITE = Color(255, 255, 255)
const RED = Color(255, 0, 0)
const GREEN = Color(0, 255, 0)
const BLUE = Color(0, 0, 255)
const YELLOW = Color(255, 255, 0)
const MAGENTA = Color(255, 0, 255)
const CYAN = Color(0, 255, 255)
const TRANSPARENT = Color(0, 0, 0, 0)

export Color
