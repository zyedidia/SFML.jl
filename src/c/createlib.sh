#!/bin/bash

gcc -c -I ../../deps/CSFML-2.2-include Graphics/*.c Window/*.c Network/*.c System/*.c
gcc -L ../../deps/CSFML-2.2-osx -I/usr/local/include -L/usr/local/lib -lsfml-system -lsfml-graphics -lsfml-window -lsfml-audio -lsfml-network -lcsfml-system.2.2.0 -lcsfml-graphics.2.2.0 -lcsfml-window.2.2.0 -lcsfml-audio.2.2.0 -lcsfml-network.2.2.0 -shared -o ../../deps/libjuliasfml.dylib *.o
rm *.o
