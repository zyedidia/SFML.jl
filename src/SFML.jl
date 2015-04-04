module SFML

using Base.Libdl.dlsym

loaded = true
if VERSION < v"0.4.0-dev"
	println("You must have at least julia 0.4 to use this package.")
	println("You currently have ", VERSION)
	loaded = false	
end

if (loaded)
	try
		Libdl.dlopen("libsfml-graphics")
	catch Exception
		println("You must have the C++ library SFML installed to use this package.")
		println("Please install it.")
		loaded = false
	end

	cd("$(Pkg.dir("SFML"))/deps/CSFML-2.2-osx/") do
		try
			global const libcsfml_graphics = Libdl.dlopen("libcsfml-graphics.2.2")
			global const libcsfml_window = Libdl.dlopen("libcsfml-window.2.2")
			global const libcsfml_network = Libdl.dlopen("libcsfml-network.2.2")
			global const libcsfml_system = Libdl.dlopen("libcsfml-system.2.2")
			global const libcsfml_audio = Libdl.dlopen("libcsfml-audio.2.2")
		catch Exception
			println("Something has gone wrong with the csfml installation. Please reinstall this package.")
			loaded = false
		end
	end
	cd("$(Pkg.dir("SFML"))/deps/") do
		global const libjuliasfml = Libdl.dlopen("libjuliasfml")
	end
end

if (loaded)
	include("julia/Network/socketStatus.jl")
	include("julia/Network/tcpSocket.jl")
	include("julia/Network/tcpListener.jl")
	include("julia/Window/keyboard.jl")
	include("julia/System/vector.jl")
	include("julia/Graphics/image.jl")
	include("julia/Graphics/color.jl")
	include("julia/Graphics/font.jl")
	include("julia/Graphics/text.jl")
	include("julia/Graphics/rect.jl")
	include("julia/Graphics/view.jl")
	include("julia/Graphics/texture.jl")
	include("julia/Graphics/sprite.jl")
	include("julia/Graphics/rectangleShape.jl")
	include("julia/Graphics/circleShape.jl")
	include("julia/Window/event.jl")
	include("julia/Graphics/renderWindow.jl")
	include("julia/Window/mouse.jl")
else
	println("Module SFML not loaded")
end

end
