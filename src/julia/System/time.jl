immutable Time
    microseconds::Int64
end

function as_seconds(time::Time)
    return Real(ccall((:sfTime_asSeconds, libcsfml_system), Cfloat, (Time,), time))
end

function as_milliseconds(time::Time)
    return ccall((:sfTime_asMilliseconds, libcsfml_system), Int32, (Time,), time)
end

function as_microseconds(time::Time)
    return ccall((:sfTime_asMicroseconds, libcsfml_system), Int64, (Time,), time)
end

function seconds(amount::Real)
    return ccall((:sfSeconds, libcsfml_system), Time, (Cfloat,), amount)
end

function milliseconds(amount::Integer)
    return ccall((:sfMilliseconds, libcsfml_system), Time, (Int32,), amount)
end

function microseconds(amount::Int64)
    return ccall((:sfMicroseconds, libcsfml_system), Time, (Int64,), amount)
end
