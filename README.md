![SFML.jl](./assets/sfmljl_logo.png)
---
This is a binding of the C++ game and multimedia library [SFML](http://www.sfml-dev.org/) (Simple and Fast Multimedia Library), developed by Laurent Gomila, for Julia. SFML is often used for game development but it can be used for anything graphics-related.

It also has audio libraries and networking libraries.

This is a work in progress. There is currently almost complete support for graphics, good support for audio, and decent support for network.

SFML.jl works on Mac OS X, Linux, and Windows.

Take a look at the `examples` folder to see some usage examples.

#Installation
You need to have Julia version 0.4, which you can get [here](http://julialang.org/downloads/) under `Nightly Builds`.

If you are using Mac OS X or Linux, you must have [SFML](http://www.sfml-dev.org/download.php) and [CSFML](http://www.sfml-dev.org/download/csfml/) **of the same version**, ideally 2.2, installed to use this binding.
For Windows users, please see the `Windows` section further down the page.

You can build these from source or use the package that your package manager provides.

#### Mac OS X
brew provides version 2.2 of SFML and CSFML.
```
$ brew install sfml
$ brew install csfml
```

#### Linux (Debian based)
apt-get provides version 2.1 of SFML and CSFML. SFML.jl supports SFML and CSFML version 2.2 but most (if not all) things will work with 2.1.
```
$ sudo apt-get install libsfml-dev
$ sudo apt-get install libcsfml-dev
```

On Linux, you also need to tell ld to look in the current directory for any shared libraries.

```
$ echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.' >> ~/.bashrc
$ source ~/.bashrc
```

#### Windows
To use this package on Windows, you must first install the [WinRPM] (https://github.com/JuliaLang/WinRPM.jl) package, and install gcc with it:

```
julia> Pkg.add("WinRPM")
julia> using WinRPM
julia> WinRPM.install("gcc")
```

You should then clone the SFML package.
```
julia> Pkg.clone("SFML")
```

Then, you must download the correct [SFML] (http://www.sfml-dev.org/download/sfml/2.2/) and [CSFML] (http://www.sfml-dev.org/download/csfml/) binaries. Make sure to download the one marked `GCC 4.9.2 MinGW` with either 32 bit or 64 bit.
Place the folders in C:\Users\YourName\.julia\SFML\deps and rename them to SFML and CSFML (not SFML-2.2 and CSFML-2.2).
Make sure that they have no inner SFML-2.2 folder or CSFML-2.2. The directory structure should be deps/SFML/lotsOfThingsHere
Once you are done with all that, you can build the package:

```
julia> Pkg.build("SFML")
```

I hope to be able to automate this process in the future.

#License

This software is a binding of the SFML library created by Laurent Gomila, which is provided under the Zlib/png license.

This software is provided under the same license as SFML, the Zlib/png license.
