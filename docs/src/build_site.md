```@meta
CurrentModule = HTMLBuilder
```

# Building a Site with Multiple Pages

## The `@build_site` macro

**HTMLBuilder.jl** offers a convenient interface to manage multiple HTML pages through the `@build_site` macro.

You will need a project directory `project` (though this can be named anything, see the [`example`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example) folder in the HTMLBuilder.jl repository). Inside this directory, create a `site` folder, which will contain the code to generate your site (see [`example/site`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/site)).

Within the `site` directory, create folders and Julia files as you like. When you are ready, run
```@repl 1
using HTMLBuilder
@build_site "/path/to/project"
```
The macro will create the `dist` directory, and parse all the Julia files in `site` to create HTML files. The file and folder structure in `site` will be reproduced in `dist`. For example [`example/site/index.jl`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/site/index.jl) will become [`example/dist/index.html`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/dist/index.html), and [`example/site/simple/fibonacci.jl`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/site/simple/fibonacci.jl) will become [`example/dist/simple/fibonacci.html`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/dist/simple/fibonacci.html).

## Julia pages

The main way to generate HTML pages is by writing a Julia file `page.jl` which returns an `HTMLElement`. The `@build_site` macro will automatically create a `page.html` page with the output of `page.jl`. For example, see [`example/site/simple/fibonacci.jl`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/site/simple/fibonacci.jl), which becomes [`example/dist/simple/fibonacci.html`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/dist/simple/fibonacci.html).

!!! warning
    There is no need to run `using HTMLBuilder` in `page.jl`. The `@build_site` macro loads the contents of `page.jl` into your active environment, so any packages and code you have already loaded can be used directly.

## Julia pages with custom paths

The path of `page.jl` can be manually specified. Instead of returning an `HTMLElement`, `page.jl` should return a `Tuple{String, HTMLElement}`, where the first element of the tuple specifies the path. For example, see [`example/site/advanced/custom_path.jl`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/site/advanced/custom_path.jl), which becomes [`example/dist/advanced/another_folder/another_path.jl`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/dist/advanced/another_folder/another_path.jl)

## Multiple Julia pages created by one file

If you want to create several pages with a single file, you can return a vector of pages: `Vector{Tuple{String, HTMLElement}}`. Each element is a `Tuple` with two elements: a custom path, and a `HTMLElement`. For example, see [`example/site/advanced/many_pages.jl`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/site/advanced/many_pages.jl), which generates all the pages in the [`example/dist/advanced/fibonacci`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/dist/advanced/fibonacci) folder.

## Redirection pages

To create a redirection, simply place a `page.txt` file in `site` which contains the redirection url. For example, see [`example/site/simple/redirection.txt`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/site/simple/redirection.txt), which becomes [`example/dist/simple/redirection.txt`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/dist/simple/redirection.html).

## Assets

If you need certain assets to be copied into your site (for instance, images), you can create an `assets` folder inside of the `project` directory. The files and folder structure within will be copied into `dist` without further processing. For example, [`example/assets/logos/logo-large.svg`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/assets/logos/logo-large.svg) is copied to [`example/dist/logos/logo-large.svg`](https://github.com/rafaelbailo/HTMLBuilder.jl/tree/main/example/dist/logos/logo-large.svg).

## Advanced configuration

You can pass a `config::NamedTuple` object to the `@build_site` macro by running
```@repl 1
using HTMLBuilder
config = (;
  # options...
)
@build_site "/path/to/project" config
```

The following options are available:
- `assets_path::String`: the path to the `assets` folder within the project's directory. Defaults to `assets`.
- `dist_path::String`: the path to the `dist` folder within the project's directory. Defaults to `dist`. 
- `site_path::String`: the path to the `site` folder within the project's directory. Defaults to `site`.
- `verbose::Bool`: controls whether verbose output should be printed as the site is built. Defaults to `false`. 
