#!/bin/bash

cd docs
~/julia -e 'using Pkg; Pkg.activate("."); include("./make.jl");'

serve ./build
