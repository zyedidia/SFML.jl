module SFML

VERSION >= v"0.4.0-dev+6521" && __precompile__()

using Compat

import Base: display, isopen, close, reset, copy, launch, start, listen,
       accept, connect, write, send, bind, download, contains,
       +, -, *, /

function check_deps(ldd_result)
    i = 0
    for line in split(ldd_result, "\n")
        if contains(line, "not found") && !contains(line, "libsfml")
            i += 1
            if i == 1
                println("Could not resolve dependencies:")
            end
            println(line)
        end
    end
end

function __init__()
    old = pwd()
    deps = joinpath(dirname(@__FILE__),"..","deps")
    push!(Libdl.DL_LOAD_PATH, deps)
    try
        @compat @static if is_unix()
            cd(deps)
            @compat @static if is_apple()
                Libdl.dlopen("freetype.framework/freetype")
                Libdl.dlopen("sndfile.framework/sndfile")
            end

            @compat @static if is_linux()
                system_deps = @compat readstring(`ldd libsfml-system.so`)
                check_deps(system_deps)
                network_deps = @compat readstring(`ldd libsfml-network.so`)
                check_deps(network_deps)
                graphics_deps = @compat readstring(`ldd libsfml-graphics.so`)
                check_deps(graphics_deps)
                audio_deps = @compat readstring(`ldd libsfml-audio.so`)
                check_deps(audio_deps)
                window_deps = @compat readstring(`ldd libsfml-window.so`)
                check_deps(window_deps)
            end

            Libdl.dlopen("libsfml-system", Libdl.RTLD_GLOBAL)
            Libdl.dlopen("libsfml-network", Libdl.RTLD_GLOBAL)
            Libdl.dlopen("libsfml-audio", Libdl.RTLD_GLOBAL)
            Libdl.dlopen("libsfml-window", Libdl.RTLD_GLOBAL)
            Libdl.dlopen("libsfml-graphics", Libdl.RTLD_GLOBAL)
            Libdl.dlopen("libcsfml-system", Libdl.RTLD_GLOBAL)
            Libdl.dlopen("libcsfml-network", Libdl.RTLD_GLOBAL)
            Libdl.dlopen("libcsfml-audio", Libdl.RTLD_GLOBAL)
            Libdl.dlopen("libcsfml-window", Libdl.RTLD_GLOBAL)
            Libdl.dlopen("libcsfml-graphics", Libdl.RTLD_GLOBAL)
            global const libcsfml_system = "libcsfml-system"
            global const libcsfml_audio = "libcsfml-audio"
            global const libcsfml_network = "libcsfml-network"
            global const libcsfml_window = "libcsfml-window"
            global const libcsfml_graphics = "libcsfml-graphics"
        end

        @compat @static if is_windows()
            global const libcsfml_system = "csfml-system-2"
            global const libcsfml_audio = "csfml-audio-2"
            global const libcsfml_network = "csfml-network-2"
            global const libcsfml_window = "csfml-window-2"
            global const libcsfml_graphics = "csfml-graphics-2"
        end

        @compat @static if is_unix()
            global const libjuliasfml_ptr = Libdl.dlopen("$deps/libjuliasfml")
        end
        global const libjuliasfml = "libjuliasfml"
        cd(old)
    catch exception
        println("Something has gone wrong with the SFML installation.")
        println(exception)
        cd(old)
    end
end

include("julia/System/vector.jl")
include("julia/System/time.jl")
include("julia/System/thread.jl")
include("julia/System/clock.jl")

include("julia/Network/networkStruct.jl")
include("julia/Network/packet.jl")
include("julia/Network/ipAddress.jl")
include("julia/Network/socketStatus.jl")
include("julia/Network/udpSocket.jl")
include("julia/Network/tcpSocket.jl")
include("julia/Network/tcpListener.jl")
include("julia/Network/http.jl")
include("julia/Network/ftp.jl")

include("julia/Audio/soundStatus.jl")
include("julia/Audio/music.jl")
include("julia/Audio/soundBuffer.jl")
include("julia/Audio/sound.jl")
include("julia/Audio/soundBufferRecorder.jl")

include("julia/Graphics/rect.jl")
include("julia/Graphics/drawable.jl")
include("julia/Graphics/transform.jl")
include("julia/Graphics/blendMode.jl")
include("julia/Graphics/videoMode.jl")
include("julia/Graphics/color.jl")
include("julia/Graphics/image.jl")
include("julia/Graphics/font.jl")
# include("julia/Graphics/rect.jl")
include("julia/Graphics/text.jl")
include("julia/Graphics/view.jl")
include("julia/Graphics/types.jl")
include("julia/Graphics/texture.jl")
include("julia/Graphics/shader.jl")
include("julia/Graphics/renderStates.jl")
include("julia/Graphics/sprite.jl")
include("julia/Graphics/convexShape.jl")
include("julia/Graphics/rectangleShape.jl")
include("julia/Graphics/vertexArray.jl")
include("julia/Graphics/circleShape.jl")
include("julia/Graphics/renderTexture.jl")

include("julia/Window/joystick.jl")
include("julia/Window/event.jl")

include("julia/Graphics/renderWindow.jl")
include("julia/Graphics/line.jl")

include("julia/Window/mouse.jl")
include("julia/Window/keyboard.jl")

include("exports.jl")

function make_gif(window::RenderWindow, width, height, duration, filename="sfmlgif.gif", delay=0.06)
    textures = Texture[]
    duration_clock = Clock()
    delay_clock = Clock()

    @async begin
        println("Taking pictures")
        while as_seconds(get_elapsed_time(duration_clock)) <= duration
            sleep(0)
            print("$(round(as_seconds(get_elapsed_time(duration_clock))/duration*100))% done\r")
            if as_seconds(get_elapsed_time(delay_clock)) >= delay
                restart(delay_clock)
                window_size = get_size(window)
                texture = Texture(window_size.x, window_size.y)
                update(texture, window)
                push!(textures, texture)
            end
        end
        make_gif(textures, width, height, filename, delay)
    end
    nothing
end

function make_gif(textures::Array{Texture}, width, height, filename="plot.gif", delay=0.06)
    images = Image[]
    for i = 1:length(textures)
        push!(images, copy_to_image(textures[i]))
    end

    println("Done taking pictures")
    make_gif(images, width, height, filename, delay)
end

function make_gif(images::Array{Image}, width, height, filename="plot.gif", delay=0.06)
    println("Please wait while your gif is made... This may take awhile")
    dir = mktempdir()
    name = filename[1:search(filename, '.')-1]
    imgsize = "$width" * "x" * "$height"

    for i = 1:length(images)
        save_to_file(images[i], "$dir/$name$i.png")
        cmd = `convert $dir/$name$i.png -resize $imgsize\! $dir/$name$i.png`
        run(cmd)
        print("$(round(i/length(images)*100))% done\r")
    end
    println("Assembling gif (this may take awhile)")
    args = reduce(vcat, [[joinpath("$dir", "$name$i.png"), "-delay",
           "$(delay * 100)", "-alpha", "remove"] for i in 1:length(images)])

    imagemagick_cmd = `convert $args $filename`
    run(imagemagick_cmd)
    rm(dir)
    println("Created gif $filename")
end

function screenshot(window::RenderWindow, filename::AbstractString)
    screenshot_img = capture(window)
    save_to_file(screenshot, filename)
end

end
