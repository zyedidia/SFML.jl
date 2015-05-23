ext = ""

@unix_only begin 
	@linux_only ext = "so"
	@osx_only ext = "dylib"

	run(`gcc -fPIC -I/usr/local/include -c Window/event.c Network/Network.c Graphics/shader.c`)
	run(`gcc -I/usr/local/include -L/usr/local/lib -lcsfml-system -lcsfml-graphics -lcsfml-window -lcsfml-audio -lcsfml-network -shared -o $(Pkg.dir("SFML"))/deps/libjuliasfml.$ext event.o Network.o shader.o`)
	run(`rm event.o shader.o Network.o`)
end

@windows_only begin
	if isdir(Pkg.dir("WinRPM"))
		RPMbindir = Pkg.dir("WinRPM","deps","usr","$(Sys.ARCH)-w64-mingw32","sys-root","mingw","bin")
		ENV["PATH"]=ENV["PATH"]*";"*RPMbindir

		mingw_include = Pkg.dir("WinRPM", "deps", "usr", "$(Sys.ARCH)-w64-mingw32", "sys-root", "mingw", "include")
		deps_dir = Pkg.dir("SFML")*"\\deps"
		run(`gcc -I$mingw_include -ISFML\\include -I$deps_dir\\CSFML\\include -c Window\\event.c Network\\Network.c Graphics\\shader.c`)
		run(`gcc -I$mingw_include -I$deps_dir\\CSFML\\include -L$deps_dir\\CSFML\\bin -lcsfml-network-2 -lcsfml-window-2 -lcsfml-graphics-2 -shared -o libjuliasfml.dll event.o shader.o Network.o`)
		rm("event.o"); rm("shader.o"); rm("Network.o")
	else
		println("Please install WinRPM and gcc to build this package")
	end
end


