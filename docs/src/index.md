```@meta
CurrentModule = HTMLBuilder
```

![HTMLBuilder.jl](https://raw.githubusercontent.com/rafaelbailo/HTMLBuilder.jl/refs/heads/main/docs/src/assets/logo-large.svg)

# HTMLBuilder.jl: Building HTML the Julia way

```@raw html
<iframe src="https://ghbtns.com/github-btn.html?user=rafaelbailo&repo=HTMLBuilder.jl&type=star&count=true&size=large" frameborder="0" scrolling="0" width="170" height="30" title="GitHub"></iframe>
```

[![Static Badge](https://img.shields.io/badge/View%20on%20Github-grey?logo=github)](https://github.com/rafaelbailo/HTMLBuilder.jl)
[![Build Status](https://github.com/rafaelbailo/HTMLBuilder.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/rafaelbailo/HTMLBuilder.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/rafaelbailo/HTMLBuilder.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/rafaelbailo/HTMLBuilder.jl)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**HTMLBuilder.jl** is a package for handling HTML in idiomatic Julia. Currently, it can:
- Generate HTML code.
- Parse HTML code.
- Build a site with multiple pages.

All the HTML elements are treated as Julia structs, so you can easily generate HTML programmatically. For instance, we can list the first `N` Fibonacci numbers. First we import **HTMLBuilder.jl** and define the `Fibonacci` function, as well as `N=5`:
```@repl 1
using HTMLBuilder
Fibonacci(n::Int) = (n <= 2) ? (1) : (Fibonacci(n - 1) + Fibonacci(n - 2));
N = 5;
```
Then, we can construct the list by nesting HTML elements and using a `for` loop:
```@repl 1
body(
  h1("The Fibonacci numbers"),
  p("Here are the first $N Fibonacci numbers:"),
  ul([li(string(Fibonacci(n))) for n ∈ 1:N]),
)
```

**HTMLBuilder.jl** can be used to build and manage a complex site through the `@build_site` macro. The [`example`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example) directory contains a [`site`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/site) directory populated with Julia code. The `@build_site` macro parses these files and generates [`dist`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/dist), a complete HTML site. For more details, see the [documentation](https://rafaelbailo.github.io/HTMLBuilder.jl/stable/build_site/).

### Bug reports, feature requests, and contributions

Please see [the contribution guidelines](https://github.com/rafaelbailo/HTMLBuilder.jl/blob/main/CONTRIBUTING.md).
