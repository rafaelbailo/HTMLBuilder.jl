#!/bin/bash

~/julia -e 'using Pkg; Pkg.activate(".."); using HTMLBuilder; @build_site "." (; verbose = true)' && serve ./dist
