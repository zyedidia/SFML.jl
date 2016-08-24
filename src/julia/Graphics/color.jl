immutable Color
    r::UInt8
    g::UInt8
    b::UInt8
    a::UInt8

    function Color(r::Integer, g::Integer, b::Integer)
        r=clamp(r, 0, 255); g=clamp(g, 0, 255); b=clamp(b, 0, 255);
        new(UInt8(r), UInt8(g), UInt8(b), UInt8(255))
    end

    function Color(r::Integer, g::Integer, b::Integer, a::Integer)
        r=clamp(r, 0, 255); g=clamp(g, 0, 255); b=clamp(b, 0, 255); a=clamp(a, 0, 255)
        new(UInt8(r), UInt8(g), UInt8(b), UInt8(a))
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
