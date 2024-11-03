```@meta
CurrentModule = HTMLBuilder
```

# Parsing HTML

**HTMLBuilder.jl** also lets you parse HTML. After loading the package with
```@repl 1
using HTMLBuilder
```
and loading the raw HTML code into a `string`,
```@repl 1
raw_HTML = raw"<div><h1>A title</h1><p>Some text.</p></div>"
```
you can parse it by running
```@repl 1
parsed = parse_HTML(raw_HTML)
```

The parsed HTML is fully compatible with the rest of the features **HTMLBuilder.jl**. For instance, you can run
```@repl 1
dv(h1("A title"), parse_HTML(raw"<p>A paragraph to be parsed.</p>"))
```
