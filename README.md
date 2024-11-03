![HTMLBuilder.jl](https://raw.githubusercontent.com/rafaelbailo/HTMLBuilder.jl/refs/heads/main/docs/src/assets/logo-large.svg)

# HTMLBuilder.jl: Building HTML the Julia way

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://rafaelbailo.github.io/HTMLBuilder.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://rafaelbailo.github.io/HTMLBuilder.jl/dev/)
[![Build Status](https://github.com/rafaelbailo/HTMLBuilder.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/rafaelbailo/HTMLBuilder.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/rafaelbailo/HTMLBuilder.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/rafaelbailo/HTMLBuilder.jl)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**HTMLBuilder.jl** is a package for handling HTML in idiomatic Julia. Currently, it can construct and parse HTML code.

All the HTML elements are treated as Julia structs, so you can easily generate HTML programmatically. For instance, we can list the first `N` Fibonacci numbers. First we import **HTMLBuilder.jl** and define the `Fibonacci` function, as well as `N=5`:
```julia
julia> using HTMLBuilder
julia> Fibonacci(n::Int) = (n <= 2) ? (1) : (Fibonacci(n - 1) + Fibonacci(n - 2));
julia> N = 5;
```
Then, we can construct the list by nesting HTML elements and using a `for` loop:
```julia
julia> body(
         h1("The Fibonacci numbers"),
         p("Here are the first $N Fibonacci numbers:"),
         ul([li(string(Fibonacci(n))) for n ∈ 1:N]),
       )
```
which returns
```html
<body>
  <h1>The Fibonacci numbers</h1>
  <p>Here are the first 5 Fibonacci numbers:</p>
  <ul>
    <li>
      1
    </li>
    <li>
      1
    </li>
    <li>
      2
    </li>
    <li>
      3
    </li>
    <li>
      5
    </li>
  </ul>
</body>
```

### Documentation

The documentation can be found [here](https://rafaelbailo.github.io/HTMLBuilder.jl).

### Bug reports, feature requests, and contributions

Please see [the contribution guidelines](https://github.com/rafaelbailo/HTMLBuilder.jl/blob/main/CONTRIBUTING.md).
