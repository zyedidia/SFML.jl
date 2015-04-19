module SFML

using Base.Libdl.dlsym

function load_libs()
	try
		global const libcsfml_graphics = Libdl.dlopen("libcsfml-graphics")
		global const libcsfml_window = Libdl.dlopen("libcsfml-window")
		global const libcsfml_network = Libdl.dlopen("libcsfml-network")
		global const libcsfml_system = Libdl.dlopen("libcsfml-system")
		global const libcsfml_audio = Libdl.dlopen("libcsfml-audio")
	catch Exception
		@linux_only println("You must have CSFML installed. Try sudo apt-get install libcsfml-dev")
		@osx_only println("You must have CSFML installed. Try brew install csfml")
	end
end

load_libs()

cd("$(Pkg.dir("SFML"))/deps/") do
	global const libjuliasfml = Libdl.dlopen("libjuliasfml")
end

include("julia/Network/networkStruct.jl")
include("julia/Network/packet.jl")
include("julia/Network/ipAddress.jl")
include("julia/Network/socketStatus.jl")
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

include("julia/Graphics/videoMode.jl")
include("julia/Graphics/image.jl")
include("julia/Graphics/color.jl")
include("julia/Graphics/font.jl")
include("julia/Graphics/text.jl")
include("julia/Graphics/rect.jl")
include("julia/Graphics/view.jl")
include("julia/Graphics/texture.jl")
include("julia/Graphics/sprite.jl")
include("julia/Graphics/convexShape.jl")
include("julia/Graphics/rectangleShape.jl")
include("julia/Graphics/circleShape.jl")

include("julia/Window/event.jl")

include("julia/Graphics/renderWindow.jl")

include("julia/Window/mouse.jl")
include("julia/Window/keyboard.jl")

end
