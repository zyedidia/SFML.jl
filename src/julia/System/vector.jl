immutable Vector3f
    x::Cfloat
    y::Cfloat
    z::Cfloat
end

abstract type Vector2 end
immutable Vector2i <: Vector2
    x::Cint
    y::Cint
end
immutable Vector2u <: Vector2
    x::UInt32
    y::UInt32
end
immutable Vector2f <: Vector2
    x::Cfloat
    y::Cfloat
end

function Vector2(x::Real, y::Real)
    typex = typeof(x); typey = typeof(y)
    if typex <: AbstractFloat || typey <: AbstractFloat
        Vector2f(x, y)
    elseif typex <: Unsigned || typey <: Unsigned
        Vector2u(x, y)
    else
        Vector2i(x, y)
    end
end

function to_vec2u(vec::Vector2)
    if typeof(vec) != Vector2u
        return Vector2u(UInt32(vec.x), UInt32(vec.y))
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

Base.contains(obj, v::Vector2) = contains(obj, v.x, v.y)

import Base.eltype
function eltype{T <: Vector2}(::Type{T})
    @assert isleaftype(T)
    typeof(T(0,0).x)
end
eltype(v::Vector2) = eltype(typeof(v))

import Base.*
*(s::Number, v::Vector2) = Vector2(s*v.x, s*v.y)
*(v::Vector2, s::Number) = s*v

import Base.==
==(v::Vector2, w::Vector2) = (v.x == w.x) & (v.y == w.y)

import Base.convert
convert{V <: Vector2}(::Type{V}, v::Vector2) = V(v.x, v.y)

Base.start(v::Vector2) = 1
Base.next(v::Vector2, i) = (v[i], i+1)
Base.done(v::Vector2, i) = i > 2
function Base.getindex(v::Vector2, i)
    if i == 1
        return v.x
    elseif i == 2
        return v.y
    else
        throw(BoundsError(v,i))
    end
end
Base.length(v::Vector2) = 2
