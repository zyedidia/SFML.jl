println("Checking dependencies")

if Libdl.find_library(["libsfml-graphics"]) == ""
	warn("You do not have the C++ library sfml installed.\nPlease install it.")
end

if VERSION < v"0.4.0-dev"
	warn("You must have at least julia 0.4 to use this package.\nYou currently have version $VERSION")
end

cd("$(Pkg.dir("SFML"))/src/c")
run(`julia createlib.jl`)

cd("../../deps")
if isfile("libjuliasfml.dylib") || isfile("libjuliasfml.so")
	println("Successfully built sfml.jl!")
else
	println("Building sfml.jl failed!")
end
