module SFML

import Base: display, isopen, close, reset, copy, launch, start, listen, accept, connect, write, send, bind
dlsym = Base.Libdl.dlsym

function __init__()
	try
		@unix_only begin
			global const libcsfml_graphics = Libdl.dlopen("libcsfml-graphics")
			global const libcsfml_window = Libdl.dlopen("libcsfml-window")
			global const libcsfml_network = Libdl.dlopen("libcsfml-network")
			global const libcsfml_system = Libdl.dlopen("libcsfml-system")
			global const libcsfml_audio = Libdl.dlopen("libcsfml-audio")
		end
		@windows_only begin
			deps = Pkg.dir("SFML")*"\\deps"
			global const libcsfml_graphics = Libdl.dlopen("$deps\\csfml-graphics-2")
			global const libcsfml_window = Libdl.dlopen("$deps\\csfml-window-2")
			global const libcsfml_network = Libdl.dlopen("$deps\\csfml-network-2")
			global const libcsfml_system = Libdl.dlopen("$deps\\csfml-system-2")
			global const libcsfml_audio = Libdl.dlopen("$deps\\csfml-audio-2")
		end
	catch Exception
		@linux_only println("You must have CSFML installed. Try sudo apt-get install libcsfml-dev")
		@osx_only println("You must have CSFML installed. Try brew install csfml")
	end

	cd("$(Pkg.dir("SFML"))/deps/") do
		global const libjuliasfml = Libdl.dlopen("libjuliasfml")
	end
end

include("julia/Network/networkStruct.jl")
include("julia/Network/packet.jl")
include("julia/Network/ipAddress.jl")
include("julia/Network/socketStatus.jl")
include("julia/Network/udpSocket.jl")
include("julia/Network/tcpSocket.jl")
include("julia/Network/tcpListener.jl")

include("julia/System/vector.jl")
include("julia/System/time.jl")
include("julia/System/thread.jl")
include("julia/System/clock.jl")

include("julia/Audio/soundStatus.jl")
include("julia/Audio/music.jl")
include("julia/Audio/soundBuffer.jl")
include("julia/Audio/sound.jl")
include("julia/Audio/soundBufferRecorder.jl")

include("julia/Graphics/drawable.jl")
include("julia/Graphics/transform.jl")
include("julia/Graphics/blendMode.jl")
include("julia/Graphics/videoMode.jl")
include("julia/Graphics/color.jl")
include("julia/Graphics/image.jl")
include("julia/Graphics/font.jl")
include("julia/Graphics/text.jl")
include("julia/Graphics/rect.jl")
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

include("julia/Window/event.jl")

include("julia/Graphics/renderWindow.jl")
include("julia/Graphics/line.jl")

include("julia/Window/mouse.jl")
include("julia/Window/keyboard.jl")

end
