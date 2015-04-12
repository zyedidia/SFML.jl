#SFML.jl
This is a binding of the C++ Game and Multimedia Library [SFML](http://www.sfml-dev.org/) (Simple and Fast Multimedia Library) for Julia. SFML is often used for game development but it can be used for anything graphics-related.

It also has audio libraries and networking libraries.

This is very much a work in progress right now. There is currently almost complete support for graphics and limited support for audio and network.

SFML.jl only works on Mac OS X (for now).

Take a look at the `examples` folder to see some usage examples.

#Installation
Currently, only Mac OS X is supported.
You also need to have Julia version 0.4, which you can get [here] (http://julialang.org/downloads/) under `Nightly Builds`.

First make sure you have sfml 2.2. You can install it with brew, or you can download it from [here] (http://www.sfml-dev.org/download.php).

```
$ brew install sfml
```

Since this package is unregistered you must use `Pkg.clone(repo)` instead of `Pkg.add(name)`

```
julia> Pkg.update()
julia> Pkg.clone("SFML")
julia> Pkg.build("SFML")
```

Julia should clone and install it for you.

You should be all set now. You can put `using SFML` at the top of your files to use the library. Take a look at the `examples` folder to get started.
