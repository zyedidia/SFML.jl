cd("$(Pkg.dir("SFML"))/src/c")
@osx_only run(`./createlib.sh libjuliasfml.dylib`)
@linux_only run(`./createlib.sh libjuliasfml.so`)

cd("../../deps")
if isfile("libjuliasfml.dylib") || isfile("libjuliasfml.so")
	println("Successfully built libjuliasfml!")
else
	println("Building libjuliasfml failed!")
end
