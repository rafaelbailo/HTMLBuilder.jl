const HTMLElementsExclamation = (:DOCTYPE,)

const HTMLElementsGhost = (:collection, :HTMLDoc)

const HTMLElementsIndent = (
  :blockquote,
  :body,
  :collection,
  :head,
  :html,
  :HTMLDoc,
  :li,
  :nav,
  :ol,
  :script,
  :section,
  :table,
  :tbody,
  :td,
  :th,
  :thead,
  :title,
  :tr,
  :ul,
)

const HTMLElementsSingleTag =
  (:br, :DOCTYPE, :hr, :img, :link, :meta, :pseudobr, :source)

const HTMLElementsOther = (
  :a,
  :b,
  :button,
  :code,
  :comment,
  :h1,
  :h2,
  :h3,
  :h4,
  :h5,
  :h6,
  :i,
  :iframe,
  :kbd,
  :maths,
  :p,
  :pre,
  :samp,
  :small,
  :span,
  :sup,
  :var,
  :video,
)

const HTMLElements = sort(
  unique((
    HTMLElementsExclamation...,
    HTMLElementsGhost...,
    HTMLElementsIndent...,
    HTMLElementsSingleTag...,
    HTMLElementsOther...,
  )),
)

const Aliases = ((:cl, :collection),)

for el ∈ HTMLElements
  @eval begin
    @register $el
    get_default_config(s::Val{$(Meta.quot(el))}) = (;
      exclamation = $(el in HTMLElementsExclamation),
      ghost = $(el in HTMLElementsGhost),
      indent = $(el in HTMLElementsIndent),
      single_tag = $(el in HTMLElementsSingleTag),
    )
    export $el
    export $(Symbol(el, :Type))
  end
end

for pair ∈ Aliases
  @eval begin
    $(pair[1])(x...) = $(pair[2])(x...)
    export $(pair[1])
  end
end

dv(args...) = HTMLElement(Val(:div), args...)
dvType = HTMLElement{Val{:div}}
get_default_config(s::Val{:div}) = (; indent = true,)
export dv
export dvType
const divType = dvType
export divType

get_default_attributes(s::Val{:DOCTYPE}) = (; html = "")

function Base.show(io::IO, x::HTMLElement{Val{:maths}})
  print(io, raw"$$")
  for child ∈ x.children
    write(io, child)
  end
  return print(io, raw"$$")
end
