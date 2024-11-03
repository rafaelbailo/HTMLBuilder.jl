```@meta
CurrentModule = HTMLBuilder
```

# HTML Elements

## Element `class`

At the heart of the **HTMLBuilder.jl** functionality is the `HTMLElement` type. Each html element is an instance of this type; for instance, `p` is of type `pType`, and alias for `HTMLElement{pVal}`, where `pVal` is an alias for `Val{:p}`. After building the element
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
element.class isa pVal
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

You can customise the default attributes of a custom element by extending the `HTMLBuilder.get_default_attributes` method:
```@repl 1
@register withCustomAttributes
HTMLBuilder.get_default_attributes(s::withCustomAttributesVal) = (; disabled = true)
withCustomAttributes()
```

## Element `config`

The `config` field contains the configuration options of an HTML element. Two options are currently available.

The `indent` option controls whether the contents of an element are indented. Compare
```@repl 1
p("Some text.")
```
with 
```@repl 1
p("Some text.", (; indent = false))
```

The `single_tag` option is used to reduce an HTML element to a single tag. This is used by default for the `br` and `img` elements:
```@repl 1
br()
img()
```

You can customise the default configuration of a custom element by extending the `HTMLBuilder.get_default_config` method:
```@repl 1
@register withCustomConfig
HTMLBuilder.get_default_config(s::withCustomConfigVal) = (; indent = true)
withCustomConfig("Some content.")
```

## Element `children`

The `children` field contains the content ("children") of an HTML element. If we define a complex HTML expression,
```@repl 1
element = body(dv(h1("A title"), p("Some text.")))
```
we can then explore the content by recursively accesing the `children` field:
```@repl 1
element.children[1]
element.children[1].children[1]
element.children[1].children[2]
```

### The `Content` type
The field `children` is always a `Vector{Content}`, where `Content = Union{HTML, AbstractString}`, and `HTML` is an abstract type. All `HTMLElements` inherit from `HTML`.

You can customise the default children of a custom element by extending the `HTMLBuilder.get_default_children` method, always returning a `Vector{Content}`:
```@repl 1
@register withCustomChildren
function HTMLBuilder.get_default_children(s::withCustomChildrenVal, config)
  return [h1("Children one"), p("Children two")]
end
withCustomChildren()
```

## Beyond the default settings

While every element has default `attributes`, `config`, and `children`, they can be specifically set on each construction. Given an `element` (such as `p`), the following are valid calls:
- Only specifying the children:
    - `element(child::Content)`
    - `element(children::Vector{Content})`
    - `element(children::Content...)`
- Specifying the attributes and the children:
    - `element(attributes::NamedTuple, child::Content)`
    - `element(attributes::NamedTuple, children::Vector{Content})`
    - `element(attributes::NamedTuple, children::Content...)`
- Specifying the children and the configuration:
    - `element(child::Content, config::NamedTuple)`
    - `element(children::Vector{Content}, config::NamedTuple)`
- Specifying the attributes, the children, and the configuration:
    - `element(attributes::NamedTuple, child::Content, config::NamedTuple)`
    - `element(attributes::NamedTuple, children::Vector{Content}, config::NamedTuple)`

Note that the order is always:
1. `attributes`
2. `child` or `children`
3. `config`
where `attributes` or `config` may be omitted. 

Note further that, when specifying several children, we must usually pass `children::Vector{Content}`. However, when `config` is not speficied, `children::Content...` is also allowed.
