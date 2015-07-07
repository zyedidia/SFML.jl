type Vector3f
    x::Cfloat
    y::Cfloat
    z::Cfloat
end

abstract Vector2
type Vector2i <: Vector2
    x::Cint
    y::Cint
end
type Vector2u <: Vector2
    x::Uint32
    y::Uint32
end
type Vector2f <: Vector2
    x::Cfloat
    y::Cfloat
end

function Vector2(x::Real, y::Real)
    typex = typeof(x); typey = typeof(y)
    if typex <: FloatingPoint || typey <: FloatingPoint
        Vector2f(x, y)
    elseif typex <: Unsigned || typey <: Unsigned
        Vector2u(x, y)
    else
        Vector2i(x, y)
    end
end

function to_vec2u(vec::Vector2)
    if typeof(vec) != Vector2u
        return Vector2u(Uint32(vec.x), Uint32(vec.y))
    else
        vec
    end
end

function to_vec2f(vec::Vector2)
    if typeof(vec) != Vector2f
        Vector2f(Float32(vec.x), Float32(vec.y))
    else
        vec
    end
end

function to_vec2i(vec::Vector2)
    if typeof(vec) != Vector2i
        Vector2i(Int32(vec.x), Int32(vec.y))
    else
        vec
    end
end

function distance_squared(vec1::Vector2, vec2::Vector2)
    (vec2.x - vec1.x)^2 + (vec2.y - vec1.y)^2
end

function distance(vec1::Vector2, vec2::Vector2)
    sqrt(distance_squared(vec1, vec2))
end

function *(vec1::Vector2, vec2::Vector2)
    Vector2(vec1.x * vec2.x, vec1.y * vec2.y)
end

function +(vec1::Vector2, vec2::Vector2)
    Vector2(vec1.x + vec2.x, vec1.y + vec2.y)
end

function -(vec1::Vector2, vec2::Vector2)
    Vector2(vec1.x - vec2.x, vec1.y - vec2.y)
end

function /(vec1::Vector2, vec2::Vector2)
    Vector2(vec1.x / vec2.x, vec1.y / vec2.y)
end
