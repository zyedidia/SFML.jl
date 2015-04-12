type Event
	ptr::Ptr{Void}
end

baremodule EventType
	const NONE = 0
	const CLOSE = 1
end

function Event()
	return Event(ccall((:new_sjEvent, "libjuliasfml"), Ptr{Void}, ()))
end

function get_type(event::Event)
	eType = ccall((:sjEvent_eventType, "libjuliasfml"), Int32, (Ptr{Void},), event.ptr)

	return eType
end

export Event, EventType, get_type
