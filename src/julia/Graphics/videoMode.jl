type VideoMode
    width::UInt32
    height::UInt32
    bits_per_pixel::UInt32

    function VideoMode(width::Integer, height::Integer, bits_per_pixel::Integer)
        return new(width, height, bits_per_pixel)
    end
    
    function VideoMode(width::Integer, height::Integer)
        return new(width, height, 32)
    end
end

function get_desktop_mode()
    return ccall((:sfVideoMode_getDesktopMode, libcsfml_window), VideoMode, ())
end

function is_valid(mode::VideoMode)
    return ccall((:sfVideoMode_isValid, libcsfml_window), Bool, (VideoMode,), mode)
end
