type Color
	r::Uint8
	g::Uint8
	b::Uint8
	a::Uint8

	function Color(r::Int, g::Int, b::Int)
		clamp(r, 0, 255); clamp(g, 0, 255); clamp(b, 0, 255);
		new(Uint8(r), Uint8(g), Uint8(b), Uint8(255))
	end

	function Color(r::Int, g::Int, b::Int, a::Int)
		clamp(r, 0, 255); clamp(g, 0, 255); clamp(b, 0, 255); clamp(a, 0, 255)
		new(Uint8(r), Uint8(g), Uint8(b), Uint8(a))
	end
end

export Color
