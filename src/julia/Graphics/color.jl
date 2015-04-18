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

export Color
