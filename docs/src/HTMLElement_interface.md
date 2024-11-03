```@meta
CurrentModule = HTMLBuilder
```

# HTML Elements

## Element `class`

At the heart of the **HTMLBuilder.jl** functionality is the `HTMLElement` type. Each html element is an instance of this type; for instance, `p` is of type `HTMLElement{Val{:p}}`, which is given the alias `pType`. After building the element
```@repl 1
using HTMLBuilder
element = p("Some text")
```
you can test its type:
```@repl 1
element isa pType
pType
```
This type is related to the element's `class` field:
```@repl 1
element.class
```

## Element `attributes`

The `attributes` field contains the information about the HTML attributes of an element's HTML tag. This is by default an empty `NamedTuple`:
```@repl 1
element = p("Some text")
element.attributes
```
However, any attributes you pass during construction will be stored there:
```@repl 1
href = "https://rafaelbailo.github.io/HTMLBuilder.jl/";
element = a((; href), "The HTMLBuilder.jl documentation")
element.attributes
```
Any attributes with value `""` or `true` will be treated as boolean HTML attributes. Attributes with value `false` will be ignored:
```@repl 1
button((; disabled=""), "Button text")
button((; disabled=true), "Button text")
button((; disabled=false), "Button text")
```

## Element `children`

## Element `config`
