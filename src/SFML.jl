module SFML

# function __init__()
# 	if !contains(VERSION, "0.4")
# 		println("You must have julia 0.4 to use this package")
# 		println("You currently have ", VERSION)
# 	end
# end

include("julia/Window/keyboard.jl")
include("julia/System/vector.jl")
include("julia/Graphics/color.jl")
include("julia/Graphics/texture.jl")
include("julia/Graphics/sprite.jl")
include("julia/Graphics/rectangleShape.jl")
include("julia/Graphics/circleShape.jl")
include("julia/Window/event.jl")
include("julia/Graphics/renderWindow.jl")

end
