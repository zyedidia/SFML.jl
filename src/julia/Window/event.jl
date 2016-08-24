type Event
    ptr::Ptr{Void}

    function Event(ptr::Ptr{Void})
        event = new(ptr)
        finalizer(event, destroy)
        event
    end
end

immutable KeyEvent
    etype::Cint
    key_code::Cint
    alt::Cint
    control::Cint
    shift::Cint
    system::Cint
end

immutable TextEvent
    etype::Cint
    unicode::UInt32
end

immutable MouseMoveEvent
    etype::Cint
    x::Cint
    y::Cint
end

immutable MouseButtonEvent
    etype::Cint
    button::Cint
    x::Cint
    y::Cint
end

immutable MouseWheelEvent
    etype::Cint
    delta::Cint
    x::Cint
    y::Cint
end

immutable JoystickMoveEvent
    etype::Cint
    joystick_id::UInt32
    axis::JoystickAxis
    position::Cfloat
end

immutable JoystickButtonEvent
    etype::Cint
    joystick_id::UInt32
    button::UInt32
end

immutable JoystickConnectEvent
    etype::Cint
    joystick_id::UInt32;
end

immutable SizeEvent
    etype::Cint
    width::UInt32
    height::UInt32
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
    Event(ccall((:new_sjEvent, "libjuliasfml"), Ptr{Void}, ()))
end

function destroy(event::Event)
    ccall((:sjEvent_destroy, "libjuliasfml"), Void, (Ptr{Void},), event.ptr)
end

function get_type(event::Event)
    return ccall((:sjEvent_eventType, "libjuliasfml"), Int32, (Ptr{Void},), event.ptr)
end

function get_size(event::Event)
    return ccall((:sjEvent_eventSize, "libjuliasfml"), SizeEvent, (Ptr{Void},), event.ptr)
end

function get_key(event::Event)
    return ccall((:sjEvent_eventKey, "libjuliasfml"), KeyEvent, (Ptr{Void},), event.ptr)
end

function get_text(event::Event)
    return ccall((:sjEvent_eventText, "libjuliasfml"), TextEvent, (Ptr{Void},), event.ptr)
end

function get_mousebutton(event::Event)
    return ccall((:sjEvent_eventMouseButton, "libjuliasfml"), MouseButtonEvent, (Ptr{Void},), event.ptr)
end

function get_mousemove(event::Event)
    return ccall((:sjEvent_eventMouseMove, "libjuliasfml"), MouseMoveEvent, (Ptr{Void},), event.ptr)
end

function get_mousewheel(event::Event)
    return ccall((:sjEvent_eventMouseWheel, "libjuliasfml"), MouseWheelEvent, (Ptr{Void},), event.ptr)
end
