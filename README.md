#SFML.jl
This is a binding of the C++ Game and Multimedia Library [SFML](http://www.sfml-dev.org/) (Simple and Fast Multimedia Library), developed by Laurent Golima, for Julia. SFML is often used for game development but it can be used for anything graphics-related.

It also has audio libraries and networking libraries.

This is very much a work in progress right now. There is currently almost complete support for graphics and limited support for audio and network.

SFML.jl only works on Mac OS X (linux support currently in progress).

Take a look at the `examples` folder to see some usage examples.

#Installation
Currently, only Mac OS X is supported.
You also need to have Julia version 0.4, which you can get [here] (http://julialang.org/downloads/) under `Nightly Builds`.

You must have SFML 2.2 installed to use this binding (CSFML comes with the package). You can install it with brew, or you can download it from [here] (http://www.sfml-dev.org/download/sfml/2.2).

```
$ brew install sfml
```

Since this package is untagged but registered you must use `Pkg.clone(repo)` instead of `Pkg.add(name)`

```
julia> Pkg.update()
julia> Pkg.clone("SFML")
julia> Pkg.build("SFML")
```

Julia should clone and install it for you.

You should be all set now. You can put `using SFML` at the top of your files to use the library. Take a look at the `examples` folder to get started.

#License

This software is a binding of the SFML library created by Laurent Gomila, which is provided under the Zlib/png license.

This software is provided under the same license than the SFML, the Zlib/png license.
