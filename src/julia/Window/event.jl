type Event
	ptr::Ptr{Void}
end

baremodule EventType
	const CLOSED = 0
	const RESIZED = 1
	const LOST_FOCUS = 2
	const GAINED_FOCUS = 3
	const TEXT_ENTERED = 4
	const KEY_PRESSED = 5
	const KEY_RELEASED = 6
	const MOUSE_WHEEL_MOVED = 7
	const MOUSE_BUTTON_PRESSED = 8
	const MOUSE_BUTTON_RELEASED = 9
	const MOUSE_MOVED = 10
	const MOUSE_ENTERED = 11
	const MOUSE_LEFT = 12
	const JOYSTICK_BUTTON_PRESSED = 13
	const JOYSTICK_BUTTON_RELEASED = 14
	const JOYSTICK_MOVED = 15
	const JOYSTICK_CONNECTED = 16
	const JOYSTICK_DISCONNECTED = 17
	const TOUCH_BEGAN = 18
	const TOUCH_MOVED = 19
	const TOUCH_ENDED = 20
	const SENSOR_CHANGED = 21
end

function Event()
	return Event(ccall(dlsym(libjuliasfml, :new_sjEvent), Ptr{Void}, ()))
end

function get_type(event::Event)
	eType = ccall(dlsym(libjuliasfml, :sjEvent_eventType), Int32, (Ptr{Void},), event.ptr)

	return eType
end

export Event, EventType, get_type
