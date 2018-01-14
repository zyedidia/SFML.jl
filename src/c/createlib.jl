ext = ""

deps = joinpath(dirname(@__FILE__),"..","..","deps")

@static if is_unix()
    @static if is_linux() ext = "so" end
    @static if is_apple() ext = "dylib" end

    run(`gcc -fPIC -I$deps/csfml/include -c Window/event.c Network/Network.c Graphics/shader.c`)
    run(`gcc -L$deps -lcsfml-system -lcsfml-graphics -lcsfml-window -lcsfml-audio -lcsfml-network -shared -o $deps/libjuliasfml.$ext event.o Network.o shader.o`)
    run(`rm event.o shader.o Network.o`)
end

@static if is_windows()
    if isdir(Pkg.dir("WinRPM"))
        RPMbindir = Pkg.dir("WinRPM","deps","usr","$(Sys.ARCH)-w64-mingw32","sys-root","mingw","bin")
        ENV["PATH"]=ENV["PATH"]*";"*RPMbindir

        mingw_include = Pkg.dir("WinRPM", "deps", "usr", "$(Sys.ARCH)-w64-mingw32", "sys-root", "mingw", "include")
        deps_dir = joinpath(dirname(@__FILE__),"..","..","deps")
        run(`gcc -I$mingw_include -I$deps_dir\\sfml-binaries\\csfml\\include -c Window\\event.c Network\\Network.c Graphics\\shader.c`)
        run(`gcc -L$deps_dir\\csfml\\bin -lcsfml-network-2 -lcsfml-window-2 -lcsfml-graphics-2 -shared -o $deps_dir\\libjuliasfml.dll event.o shader.o Network.o`)
        rm("event.o"); rm("shader.o"); rm("Network.o")
    else
        println("Please install WinRPM and gcc to build this package")
    end
end


