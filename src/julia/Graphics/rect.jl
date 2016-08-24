immutable FloatRect
    left::Cfloat
    top::Cfloat
    width::Cfloat
    height::Cfloat
end

immutable IntRect
    left::Cint
    top::Cint
    width::Cint
    height::Cint
end

function contains(rect::FloatRect, x::Real, y::Real)
    rectPtr = Ref{FloatRect}(rect)
    return ccall((:sfFloatRect_contains, libcsfml_graphics), Int32, (Ref{FloatRect}, Cfloat, Cfloat,), (rectPtr), x, y) == 1
end

function contains(rect::IntRect, x::Int, y::Int)
    rectPtr = Ref{FloatRect}(rect)
    return ccall((:sfIntRect_contains, libcsfml_graphics), Int32, (Ref{IntRect}, Cint, Cint,), (rectPtr), x, y) == 1
end

function intersects(rect1::FloatRect, rect2::FloatRect)
    rect1Ptr = Ref{FloatRect}(rect1)
    rect2Ptr = Ref{FloatRect}(rect2)
    return Bool(ccall((:sfFloatRect_intersects, libcsfml_graphics), Int32, (Ref{FloatRect}, Ref{FloatRect}, Ptr{FloatRect},), (rect1Ptr), (rect2Ptr), C_NULL))
end

function intersects(rect1::IntRect, rect2::IntRect)
    rect1Ptr = Ref{FloatRect}(rect1)
    rect2Ptr = Ref{FloatRect}(rect2)
    return ccall((:sfIntRect_intersects, libcsfml_graphics), Int32, (Ref{IntRect}, Ref{IntRect}, Ptr{IntRect},), (rect1Ptr), (rect2Ptr), C_NULL) == 1
end
