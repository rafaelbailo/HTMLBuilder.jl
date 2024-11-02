push!(LOAD_PATH, "../src/")

using HTMLBuilder
using Documenter

DocMeta.setdocmeta!(
  HTMLBuilder,
  :DocTestSetup,
  :(using HTMLBuilder);
  recursive = true,
)

makedocs(;
  modules = [HTMLBuilder],
  authors = "Dr Rafael Bailo",
  repo = "https://github.com/rafaelbailo/HTMLBuilder.jl/blob/{commit}{path}#{line}",
  sitename = "HTMLBuilder.jl",
  format = Documenter.HTML(;
    sidebar_sitename = false,
    prettyurls = get(ENV, "CI", "false") == "true",
    canonical = "https://rafaelbailo.github.io/HTMLBuilder.jl",
    edit_link = "main",
    assets = ["assets/favicon.ico"],
    footer = "Copyright © 2024 [Dr Rafael Bailo](https://rafaelbailo.com/). [MIT License](https://github.com/rafaelbailo/HTMLBuilder.jl/blob/main/LICENSE).",
  ),
  pages = ["Home" => "index.md"],
)

deploydocs(; repo = "github.com/rafaelbailo/HTMLBuilder.jl", devbranch = "main")
