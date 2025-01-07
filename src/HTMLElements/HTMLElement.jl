struct HTMLElement{A, B, C, D} <: HTML
  class::A
  attributes::B
  children::C
  config::D
end

function HTMLElement(
  class::A,
  attributes::B,
  children::C,
  config::D = (;),
) where {A <: Val, B <: NamedTuple, C <: Vector{<:Content}, D <: NamedTuple}
  default_attributes = get_default_attributes(class)
  computed_attributes = merge(default_attributes, attributes)

  default_config = merge(
    get_default_config(class),
    (children == [""]) ? ((; indent = false)) : (NamedTuple()),
  )
  computed_config = merge(default_config, config)

  default_children = get_default_children(class, computed_config)
  computed_children = Content[default_children..., children...]

  filtered_children = filter(s -> s != "", computed_children)
  computed_children =
    (length(filtered_children) == 0) ? (Content[""]) : (filtered_children)

  if any(map(s -> s isa collectionType, computed_children))
    expanded_children =
      map(s -> (s isa collectionType) ? (s.children) : ([s]), computed_children)
    computed_children = collect(Iterators.flatten(expanded_children))
  end

  if (class isa Val{:collection}) && (length(computed_children) == 1)
    return computed_children[1]
  end

  return HTMLElement{
    A,
    typeof(computed_attributes),
    typeof(computed_children),
    typeof(computed_config),
  }(
    class,
    computed_attributes,
    computed_children,
    computed_config,
  )
end
export HTMLElement

@equality_by_fields HTMLElement

function HTMLElement(
  class::A,
  children::C,
  config::D = (;),
) where {A <: Val, C <: Vector{<:Content}, D <: NamedTuple}
  return HTMLElement(class, NamedTuple(), children, config)
end

function HTMLElement(
  class::A,
  attributes::B,
  child::C,
  config::D = (;),
) where {A <: Val, B <: NamedTuple, C <: Content, D <: NamedTuple}
  return HTMLElement(class, attributes, [child], config)
end

function HTMLElement(
  class::A,
  child::C,
  config::D = (;),
) where {A <: Val, C <: Content, D <: NamedTuple}
  return HTMLElement(class, NamedTuple(), [child], config)
end

function HTMLElement(
  class::A,
  attributes::B = (;),
) where {A <: Val, B <: NamedTuple}
  return HTMLElement(class, attributes, "")
end

function HTMLElement(
  class::A,
  attributes::B,
  children...,
) where {A <: Val, B <: NamedTuple}
  return HTMLElement(class, attributes, Content[children...])
end

function HTMLElement(class::A, children...) where {A <: Val}
  return HTMLElement(class, NamedTuple(), Content[children...])
end

get_default_attributes(s::Val) = NamedTuple()

get_default_config(s::Val) = NamedTuple()

get_default_children(s::Val, config) = Content[]

function Base.show(io::IO, x::HTMLElement{Val{S}}) where {S}
  config = x.config
  exclamation = check_key(config, :exclamation)
  questions = check_key(config, :questions)
  ghost = check_key(config, :ghost)
  single_tag = check_key(config, :single_tag)
  indent = check_key(config, :indent)

  line = indent ? "\n" : ""
  ind = get(io, :indent, 0)
  next_ind = (ghost) ? (ind) : (ind + 2)
  inner_io = IOContext(io::IO, :indent => (indent ? next_ind : 0))

  if !ghost
    print(inner_io, [" " for k ∈ 1:ind]...)
    if x isa commentType
      print(inner_io, left_comment_tag())
    else
      print(
        inner_io,
        tag(
          S,
          x.attributes,
          left_exclamation = exclamation,
          left_question = questions,
          right_question = questions,
        ),
      )
    end
    print(inner_io, line)
  end

  if !single_tag
    for y ∈ x.children
      if y != ""
        if y isa AbstractString
          print(inner_io, [" " for k ∈ 1:(indent ? next_ind : 0)]...)
          print(inner_io, y)
        else
          print(inner_io, y)
        end
        if (y isa AbstractString) || !check_key(y.config, :ghost)
          print(inner_io, line)
        end
      end
    end
  end

  if !ghost && !single_tag
    if indent
      print(inner_io, [" " for k ∈ 1:ind]...)
    end
    if x isa commentType
      print(inner_io, right_comment_tag())
    else
      print(inner_io, close_tag(S))
    end
  end
end

Base.write(io::IO, x::HTMLElement) = write(io, string(x))
