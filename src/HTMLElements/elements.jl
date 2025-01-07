const HTMLElementsExclamation = (:DOCTYPE,)

const HTMLElementsQuestions = (:xml,)

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
  (:br, :DOCTYPE, :hr, :img, :link, :meta, :pseudobr, :source, :xml)

const HTMLElementsOther = (
  :a,
  :b,
  :button,
  :code,
  :comment,
  :file,
  :h1,
  :h2,
  :h3,
  :h4,
  :h5,
  :h6,
  :i,
  :iframe,
  :kbd,
  :manifest,
  :maths,
  :metadata,
  :p,
  :pre,
  :resource,
  :resources,
  :samp,
  :schema,
  :schemaversion,
  :small,
  :span,
  :sup,
  :var,
  :video,
)

const HTMLElements = sort(
  unique((
    HTMLElementsExclamation...,
    HTMLElementsQuestions...,
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
    get_default_config(s::$(Symbol(el, :Val))) = (;
      questions = $(el in HTMLElementsQuestions),
      exclamation = $(el in HTMLElementsExclamation),
      ghost = $(el in HTMLElementsGhost),
      indent = $(el in HTMLElementsIndent),
      single_tag = $(el in HTMLElementsSingleTag),
    )
    export $el
    export $(Symbol(el, :Val))
    export $(Symbol(el, :Type))
  end
end

for pair ∈ Aliases
  @eval begin
    $(pair[1])(x...) = $(pair[2])(x...)
    export $(pair[1])
  end
end

const dvVal = Val{:div}
const divVal = dvVal

const dvType = HTMLElement{dvVal}
const divType = dvType

dv(args...) = HTMLElement(dvVal(), args...)
get_default_config(s::dvVal) = (; indent = true,)

export dv, dvVal, divVal, dvType, divType

get_default_attributes(s::DOCTYPEVal) = (; html = "")

function Base.show(io::IO, x::mathsType)
  print(io, raw"$$")
  for child ∈ x.children
    write(io, child)
  end
  return print(io, raw"$$")
end
