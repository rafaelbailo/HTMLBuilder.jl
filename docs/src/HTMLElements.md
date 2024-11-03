```@meta
CurrentModule = HTMLBuilder
```

# HTML Elements

## Constructing HTML elements

**HTMLBuilder.jl** lets you construct HTML elements in idiomatic Julia. For example, after loading the package with
```@repl 1
using HTMLBuilder
```
you can create a `p` (paragraph) element by running
```@repl 1
p("Some text.")
```
You can also pass multiple arguments to an element:
```@repl 1
p("Some text. ", "Some more text.")
```

## Nesting elements

HTML elements can be nested. For instance, you can format text using the `b` (bold) and `i` (italic) tags:
```@repl 1
p("Some text. ", b("Some bold text."))
```
## Automatic indentation

!!! warning
    The `div` tag is exported as `dv` to avoid conflicts with the `Base.div` method.

Some tags include custom indentation formatting:
```@repl 1
body(dv(h1("A title"), p("Some text.")))
```

## HTML attributes

To include the HTML attributes of an element, pass a `NamedTuple` as the first argument with the names and values of the attributes. We can first define paths urls to the **HTMLBuilder.jl** logo
```@repl 1
src = "https://raw.githubusercontent.com/rafaelbailo/HTMLBuilder.jl/refs/heads/main/docs/src/assets/logo.svg";
```
and to this documentation
```@repl 1
href = "https://rafaelbailo.github.io/HTMLBuilder.jl/";
```
Then, an `img` element can be constructed as
```@repl 1
img((; src, alt = "The HTMLBuilder.jl logo", width = 500))
```
Any additional arguments passed to the element will be treated as content. An `a` (hyperlink) element with text can be constructed as
```@repl 1
a((; href), "The HTMLBuilder.jl documentation")
```

## Register your own HTML elements

If you need to use an HTML element not exported by **HTMLBuilder.jl**, you can simply add your own with the `@register` macro:
```@repl 1
@register customelement
```
Now you can work with the new element as you would with any other:
```@repl 1
dv(customelement("Some content."), p("Some more content."))
```
