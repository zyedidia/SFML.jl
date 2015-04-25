type Event
	ptr::Ptr{Void}
end

type KeyEvent
	etype::Cint
	key_code::Cint
	alt::Cint
	control::Cint
	shift::Cint
	system::Cint
end

type TextEvent
	etype::Cint
	unicode::Uint32
end

type MouseMoveEvent
	etype::Cint
	x::Cint
	y::Cint
end

type MouseButtonEvent
	etype::Cint
	button::Cint
	x::Cint
	y::Cint
end

type MouseWheelEvent
	etype::Cint
	delta::Cint
	x::Cint
	y::Cint
end

type SizeEvent
	etype::Cint
	width::Uint32
	height::Uint32
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

function destroy(event::Event)
	ccall(dlsym(libjuliasfml, :sjEvent_destroy), Void, (Ptr{Void},), event.ptr)
	event = nothing
end

function get_type(event::Event)
	return ccall(dlsym(libjuliasfml, :sjEvent_eventType), Int32, (Ptr{Void},), event.ptr)
end

function get_size(event::Event)
	return ccall(dlsym(libjuliasfml, :sjEvent_eventSize), SizeEvent, (Ptr{Void},), event.ptr)
end

function get_key(event::Event)
	return ccall(dlsym(libjuliasfml, :sjEvent_eventKey), KeyEvent, (Ptr{Void},), event.ptr)
end

function get_text(event::Event)
	return ccall(dlsym(libjuliasfml, :sjEvent_eventText), TextEvent, (Ptr{Void},), event.ptr)
end

function get_mousebutton(event::Event)
	return ccall(dlsym(libjuliasfml, :sjEvent_eventMouseButton), MouseButtonEvent, (Ptr{Void},), event.ptr)
end

function get_mousemove(event::Event)
	return ccall(dlsym(libjuliasfml, :sjEvent_eventMouseMove), MouseMoveEvent, (Ptr{Void},), event.ptr)
end

function get_mousewheel(event::Event)
	return ccall(dlsym(libjuliasfml, :sjEvent_eventMouseWheel), MouseWheelEvent, (Ptr{Void},), event.ptr)
end

export Event, EventType, get_type, KeyEvent, TextEvent, MouseButtonEvent, MouseMoveEvent, MouseWheelEvent,
SizeEvent, get_size, get_key, get_text, get_mousebutton, get_mousemove, get_mousewheel, destroy
