#!/bin/bash
#Install the dependencies and build the library in ./build
cd build
cmake ../
make -j 8
