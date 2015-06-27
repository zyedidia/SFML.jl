type Time
	microseconds::Int64
end

function as_seconds(time::Time)
	return Real(ccall((:sfTime_asSeconds, "libcsfml-system"), Cfloat, (Time,), time))
end

function as_milliseconds(time::Time)
	return ccall((:sfTime_asMilliseconds, "libcsfml-system"), Int32, (Time,), time)
end

function as_microseconds(time::Time)
	return ccall((:sfTime_asMicroseconds, "libcsfml-system"), Int64, (Time,), time)
end

function seconds(amount::Real)
	return ccall((:sfTime_sfSeconds, "libcsfml-system"), Time, (Cfloat,), amount)
end

function milliseconds(amount::Integer)
	return ccall((:sfTime_sfSeconds, "libcsfml-system"), Time, (Int32,), amount)
end

function microseconds(amount::Int64)
	return ccall((:sfTime_sfSeconds, "libcsfml-system"), Time, (Int64,), amount)
end
