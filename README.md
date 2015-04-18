#SFML.jl
This is a binding of the C++ game and multimedia library [SFML](http://www.sfml-dev.org/) (Simple and Fast Multimedia Library), developed by Laurent Golima, for Julia. SFML is often used for game development but it can be used for anything graphics-related.

It also has audio libraries and networking libraries.

This is very much a work in progress right now. There is currently almost complete support for graphics and limited support for audio and network.

SFML.jl only works on Mac OS X and Linux.

Take a look at the `examples` folder to see some usage examples.

#Installation
Currently, Mac OS X and Linux are supported.
You also need to have Julia version 0.4, which you can get [here](http://julialang.org/downloads/) under `Nightly Builds`.

You must have [SFML](http://www.sfml-dev.org/download.php) and [CSFML](http://www.sfml-dev.org/download/csfml/) **of the same version**, ideally 2.2, installed to use this binding.

You can build these from source or use the package that your package manager provides.

#### Mac OS X
brew provides version 2.2 of sfml and csfml.
```
$ brew install sfml
$ brew install csfml
```

#### Linux (Debian based)
apt-get provides version 2.1 of sfml and csfml. SFML.jl supports SFML and CSFML version 2.2 but most (if not all) things will work with 2.1.
```
$ sudo apt-get install libsfml-dev
$ sudo apt-get install libcsfml-dev
```

---

To install the package, use `Pkg.add("SFML")`

```
julia> Pkg.update()
julia> Pkg.add("SFML")
```

Julia should clone and build it for you.

You should be all set now. You can put `using SFML` at the top of your files to use the library. Take a look at the `examples` folder to get started.

#License

This software is a binding of the SFML library created by Laurent Gomila, which is provided under the Zlib/png license.

This software is provided under the same license than the SFML, the Zlib/png license.
