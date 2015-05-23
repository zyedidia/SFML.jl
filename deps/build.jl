println("Checking dependencies")

if VERSION < v"0.4.0-dev"
	error("You must have at least julia 0.4 to use this package.\nYou currently have version $VERSION")
end

@unix_only begin
	if Libdl.find_library(["libsfml-graphics"]) == ""
		@osx_only warn("You do not have sfml installed. Try 'brew install sfml'")
		@linux_only warn("You do not have sfml installed. Try 'sudo apt-get install libsfml-dev'")
	end

	if Libdl.find_library(["libcsfml-graphics"]) == ""
		@osx_only warn("You do not have csfml installed. Try 'brew install csfml'")
		@linux_only warn("You do not have csfml installed. Try 'sudo apt-get install libcsfml-dev'")
	end
end

@windows_only begin
	if !isdir(Pkg.dir("WinRPM"))
		warn("Please install WinRPM and gcc with it.")
	end

	deps = Pkg.dir("SFML")*"\\deps"
	if !isdir("$deps\\CSFML")
		warn("Please place the CSFML binaries in $deps")
	end
	if !isdir("$deps\\SFML")
		warn("Please place the SFML binaries in $deps")
	end

	cp("$deps\\CSFML\\bin\\", deps)
	cp("$deps\\SFML\\bin\\", deps)
end

cd("$(Pkg.dir("SFML"))/src/c")
run(`julia createlib.jl`)

cd("../../deps")
if isfile("libjuliasfml.dylib") || isfile("libjuliasfml.so") || isfile("libjuliasfml.dll")
	println("Successfully built SFML.jl!")
else
	println("Building SFML.jl failed!")
end
