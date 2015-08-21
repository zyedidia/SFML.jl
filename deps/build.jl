@windows_only using WinRPM

function copy_libs(src, dst)
    files = readdir(src)

    for i = 1:length(files)
        file = files[i]
        if ismatch(r"\w*?-\w*?(-.)?.(so|dylib|dll)$", file)
            cp("$src/$file", "$dst/$file", follow_symlinks=true, remove_destination=true)
        end
    end
end

function symlink_files(dir, ext)
    cd(dir)
    files = readdir(dir)
    for i = 1:length(files)
        file = files[i]
        filename = file[1:search(file, '.') - 1]
        if ismatch(r"\w*?-\w*?.(so|dylib|dll)$", file)
            run(`ln -sf $filename.$ext $file`)
        end
    end
end

function mkdir_if_necessary(dir)
    if !isdir(dir)
        mkdir(dir)
    end
end

deps = Pkg.dir("SFML")*"/deps"
cd(deps)

@osx_only begin
    sfml = "http://www.sfml-dev.org/files/SFML-2.2-osx-clang-universal.tar.gz"
    csfml = "http://www.sfml-dev.org/files/CSFML-2.2-osx-clang-universal.tar.gz"

    if !isfile("sfml.tar.gz")
        println("Downloading SFML...")
        download(sfml, "sfml.tar.gz")
    end
    if !isfile("csfml.tar.gz")
        println("Downloading CSFML...")
        download(csfml, "csfml.tar.gz")
    end

    mkdir_if_necessary("sfml")
    run(`tar -xzf sfml.tar.gz -C sfml --strip-components=1`)

    mkdir_if_necessary("csfml")
    run(`tar -xzf csfml.tar.gz -C csfml --strip-components=1`)

    symlink_files("$deps/csfml/lib", "2.2.0.dylib")

    copy_libs("$deps/sfml/lib", deps)
    copy_libs("$deps/csfml/lib", deps)

    cp("$deps/sfml/extlibs/freetype.framework", "$deps/freetype.framework", remove_destination=true)
    cp("$deps/sfml/extlibs/sndfile.framework", "$deps/sndfile.framework", remove_destination=true)

    cd(deps)
    modules = ["system", "network", "audio", "window", "graphics"]
    for i = 1:length(modules)
        run(`ln -sf libcsfml-$(modules[i]).dylib libcsfml-$(modules[i]).2.2.dylib`)
    end
end

@linux_only begin
    sfml = "http://www.sfml-dev.org/files/SFML-2.2-linux-gcc-$WORD_SIZE-bit.tar.gz"
    csfml = "http://www.sfml-dev.org/files/CSFML-2.2-linux-gcc-$WORD_SIZE-bit.tar.bz2"

    if !isfile("sfml.tar.gz")
        println("Downloading SFML...")
        download(sfml, "sfml.tar.gz")
    end
    if !isfile("csfml.tar.bz2")
        println("Downloading CSFML...")
        download(csfml, "csfml.tar.bz2")
    end

    mkdir_if_necessary("sfml")
    run(`tar -xzf sfml.tar.gz -C sfml --strip-components=1`)

    mkdir_if_necessary("csfml")
    run(`tar -xjf csfml.tar.bz2 -C csfml --strip-components=1`)

    symlink_files("$deps/csfml/lib", "so.2.2.0")

    copy_libs("$deps/sfml/lib", deps)
    copy_libs("$deps/csfml/lib", deps)

    cd(deps)
    modules = ["system", "network", "audio", "window", "graphics"]
    for i = 1:length(modules)
        run(`ln -sf libcsfml-$(modules[i]).so libcsfml-$(modules[i]).so.2.2`)
    end
end

@windows_only begin
    RPMbindir = Pkg.dir("WinRPM","deps","usr","$(Sys.ARCH)-w64-mingw32","sys-root","mingw","bin")
    if !isdir(RPMbindir)
        println("Installing gcc...")
        WinRPM.install("gcc")
    end

    cd(deps)
    deps_files = readdir(deps)

    for i = 1:length(deps_files)
        file = deps_files[i]
        if file != "build.jl"
            rm(file, recursive=true)
        end
    end

    println("Downloading SFML and CSFML")
    run(`git clone https://github.com/zyedidia/sfml-binaries.git`)

    mv("sfml-binaries/sfml/sfml-$WORD_SIZE", "sfml")
    mv("sfml-binaries/csfml/csfml-$WORD_SIZE", "csfml")

    copy_libs("$deps/sfml/bin", deps)
    copy_libs("$deps/csfml/bin", deps)

    cd(deps)
    # Rename all the dlls to have unix-like names
    mv("sfml-window-2.dll", "libsfml-window.dll")
    mv("sfml-graphics-2.dll", "libsfml-graphics.dll")
    mv("sfml-network-2.dll", "libsfml-network.dll")
    mv("sfml-audio-2.dll", "libsfml-audio.dll")
    mv("sfml-system-2.dll", "libsfml-system.dll")

    mv("csfml-window-2.dll", "libcsfml-window.dll")
    mv("csfml-graphics-2.dll", "libcsfml-graphics.dll")
    mv("csfml-network-2.dll", "libcsfml-network.dll")
    mv("csfml-audio-2.dll", "libcsfml-audio.dll")
    mv("csfml-system-2.dll", "libcsfml-system.dll")
end

cd("$(Pkg.dir("SFML"))/src/c")
run(`julia createlib.jl`)

cd(deps)

rm("sfml", recursive=true)
rm("csfml", recursive=true)

if isfile("libjuliasfml.dylib") || isfile("libjuliasfml.so") || isfile("libjuliasfml.dll")
    println("Successfully built SFML.jl!")
else
    println("Building SFML.jl failed!")
end
