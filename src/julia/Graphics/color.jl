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

const black = Color(0, 0, 0)
const white = Color(255, 255, 255)
const red = Color(255, 0, 0)
const green = Color(0, 255, 0)
const blue = Color(0, 0, 255)
const yellow = Color(255, 255, 0)
const magenta = Color(255, 0, 255)
const cyan = Color(0, 255, 255)
const transparent = Color(0, 0, 0, 0)

export Color
