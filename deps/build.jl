cd("$(Pkg.dir("SFML"))/src/c")
@osx_only run(`julia createlib.jl`)
@linux_only begin
	old_ldpath = ENV["LD_LIBRARY_PATH"]
	ENV["LD_LIBRARY_PATH"] = ".:$(old_ldpath)"
	run(`julia createlib.jl`)
	ENV["LD_LIBRARY_PATH"] = old_ldpath
end

cd("../../deps")
if isfile("libjuliasfml.dylib") || isfile("libjuliasfml.so")
	println("Successfully built libjuliasfml!")
else
	println("Building libjuliasfml failed!")
end
