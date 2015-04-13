cd("$(Pkg.dir("SFML"))/src/c")
@osx_only run(`./createlib.sh libjuliasfml.dylib`)
@linux_only do
	old_ldpath = ENV["LD_LIBRARY_PATH"]
	ENV["LD_LIBRARY_PATH"] = ".:$(old_ldpath)"
	run(`./createlib.sh libjuliasfml.so`)
	ENV["LD_LIBRARY_PATH"] = old_ldpath
end

cd("../../deps")
if isfile("libjuliasfml.dylib") || isfile("libjuliasfml.so")
	println("Successfully built libjuliasfml!")
else
	println("Building libjuliasfml failed!")
end
