#!/bin/bash

gcc -fPIC -I/usr/local/include -c Window/*.c Network/*.c Graphics/*.c
gcc -I/usr/local/include -L/usr/local/lib -lsfml-system -lsfml-graphics -lsfml-window -lsfml-audio -lsfml-network -lcsfml-system -lcsfml-graphics -lcsfml-window -lcsfml-audio -lcsfml-network -shared -o ../../deps/$1 *.o
rm *.o
