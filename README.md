#SFML.jl
This is a binding of the C++ Game and Multimedia Library [SFML](http://www.sfml-dev.org/) (Simple and Fast Multimedia Library) for Julia. SFML is often used for game development but it can be used for anything graphics-related.

It also has audio libraries and networking libraries.

This is very much a work in progress right now and should be used at your own risk (I really mean it). It also only works on Mac OS X (for now).

Take a look at `examples/game.jl` to see the latest example.

#Installation
Currently, only Mac OS X is supported
You also need to have Julia version 0.4, which you can get [here] (http://julialang.org/downloads/) under `Nightly Builds`.

First make sure you have sfml 2.2. You can install it with brew

```
$ brew install sfml
```

Package installation instructions:

Since this package is unregistered you must use `Pkg.clone(repo)` instead of `Pkg.add(name)`

```
julia> Pkg.clone("https://github.com/zyedidia/SFML.jl.git")
```

Julia should clone and install it for you.

Finally, you must set the environment variable `DYLD_LIBRARY_PATH` so that csfml gets loaded.

To do that, run the following command
```
$ echo 'export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:~/.julia/v0.4/SFML/deps' >> ~/.bashrc
$ source ~/.bashrc
```

You should be all set now. You can put `using SFML` at the top of your files to use the library. Take a look at `examples/game.jl` to see an example.
