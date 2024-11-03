#!/bin/bash

~/julia -e 'using Pkg; Pkg.activate("."); Pkg.test();'
