@enum(JoystickAxis,
    joystickX,    #< The X axis
    joystickY,    #< The Y axis
    joystickZ,    #< The Z axis
    joystickR,    #< The R axis
    joystickU,    #< The U axis
    joystickV,    #< The V axis
    joystickPovX, #< The X axis of the point-of-view hat
    joystickPovY  #< The Y axis of the point-of-view hat
)

function is_connected(joystick::Integer)
    ccall((:sfJoystick_isConnected, libcsfml_window), Bool, (UInt32,), joystick)
end

function get_button_count(joystick::Integer)
    ccall((:sfJoystick_getButtonCount, libcsfml_window), UInt32, (UInt32,), joystick)
end

function has_axis(joystick::Integer, axis::JoystickAxis)
    ccall((:sfJoystick_hasAxis, libcsfml_window), Bool, (UInt32, Int32,), joystick, axis)
end

function is_button_pressed(joystick::Integer, button::Integer)
    ccall((:sfJoystick_isButtonPressed, libcsfml_window), Bool, (UInt32, UInt32,), joystick, button)
end

function get_axis_position(joystick::Integer, axis::JoystickAxis)
    ccall((:sfJoystick_getAxisPosition, libcsfml_window), Float32, (UInt32, Int32,), joystick, axis)
end

function joystick_update()
    ccall((:sfJoystick_update, libcsfml_window), Void, ())
end
