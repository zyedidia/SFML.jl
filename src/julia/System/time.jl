type Time
	microseconds::Int64
end

function as_seconds(time::Time)
	return Real(ccall(dlsym(libcsfml_system, :sfTime_asSeconds), Cfloat, (Time,), time))
end

function as_milliseconds(time::Time)
	return ccall(dlsym(libcsfml_system, :sfTime_asMilliseconds), Int32, (Time,), time)
end

function as_microseconds(time::Time)
	return ccall(dlsym(libcsfml_system, :sfTime_asMicroseconds), Int64, (Time,), time)
end

function seconds(amount::Real)
	return ccall(dlsym(libcsfml_system, :sfTime_sfSeconds), Time, (Cfloat,), amount)
end

function milliseconds(amount::Integer)
	return ccall(dlsym(libcsfml_system, :sfTime_sfSeconds), Time, (Int32,), amount)
end

function microseconds(amount::Int64)
	return ccall(dlsym(libcsfml_system, :sfTime_sfSeconds), Time, (Int64,), amount)
end

export Time, as_seconds, as_microseconds, as_milliseconds, seconds, milliseconds, microseconds
