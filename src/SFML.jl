module SFML

loaded = true
if VERSION < v"0.4.0-dev"
	println("You must have at least julia 0.4 to use this package")
	println("You currently have ", VERSION)
	loaded = false	
end

try
	Libdl.dlopen("libcsfml-graphics")
catch Exception
	println("Something has gone wrong with the csfml installation. Please reinstall this package")
	loaded = false
end

try
	Libdl.dlopen("libsfml-graphics")
catch Exception
	println("You must have the C++ library SFML installed to use this package")
	println("Please install it")
	loaded = false
end

if (loaded)
	include("julia/Window/keyboard.jl")
	include("julia/System/vector.jl")
	include("julia/Graphics/color.jl")
	include("julia/Graphics/font.jl")
	include("julia/Graphics/text.jl")
	include("julia/Graphics/rect.jl")
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
