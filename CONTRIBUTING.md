# Contributing to HTMLBuilder.jl

We are always happy to receive community contributions, thank you in advance for your contribution and for reading through these guidelines! We are open to various inputs, including but not limited to
- new features;
- feature requests;
- bug reports;
- bug fixes;
- documentation.

## How to contribute

### Features, bug fixes, and documentation

The preferred workflow is to fork the HTMLBuilder.jl repository, to commit your changes to the fork, and to create a pull request.

HTMLBuilder.jl employs unit tests to ensure code quality. Please make sure that your contribution passes all unit tests before creating the pull request.

**To run the tests locally** (preferred): activate the Julia environment in your local clone of the fork, and then run
```julia
using Pkg; Pkg.test()
```

**To run the tests on Github**: you will have to enable [GitHub workflows](https://github.com/rafaelbailo/HTMLBuilder/blob/main/.github/workflows/CI.yml) on your fork. Workflows are turned off by default in forks for security reasons. Unit tests are run as part of the *CI* (continuous integration) [GitHub action](https://docs.github.com/en/actions).

### Feature requests and bug reports

If you want to request a new feature or report a bug (e.g. wrong output, unexpected behaviour), please [open an issue here](https://github.com/rafaelbailo/HTMLBuilder.jl/issues/new/choose). There are *Feature request* and *Bug report* templates that might be useful.
