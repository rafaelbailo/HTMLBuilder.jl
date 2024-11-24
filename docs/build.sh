#!/bin/bash

~/julia -e 'using Pkg; Pkg.activate("."); include("./make.jl");' && serve ./build
