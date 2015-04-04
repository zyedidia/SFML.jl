type Event
	ptr::Ptr{Void}
end

baremodule EventType
	const NONE = 0
	const CLOSE = 1
end

function Event()
	return Event(ccall(dlsym(libjuliasfml, :new_sjEvent), Ptr{Void}, ()))
end

function get_type(event::Event)
	eType = ccall(dlsym(libjuliasfml, :sjEvent_eventType), Int32, (Ptr{Void},), event.ptr)

	return eType
end

export Event, EventType, get_type
