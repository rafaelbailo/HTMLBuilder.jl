macro parse_julia_page(source, target, verbose)
  return esc(
    quote
      page = include(source)
      parsed_target =
        HTMLBuilder.parse_julia_page(source, target, page, verbose)
    end,
  )
end

parse_julia_page(source, target, page::Nothing, verbose) = nothing;

function parse_julia_page(source, target, page::HTMLElement, verbose = false)
  @verbose_print "Building $target." verbose

  mkpath(dirname(target))
  open(target, "w") do f
    write(f, comment(" $(HTMLBuilder.HTMLBuilder_SIGNATURE) "))
    return write(f, page)
  end
  return target
end

function parse_julia_page(
  source,
  target,
  tuple::Tuple{<:String, <:HTMLElement},
  verbose = false,
)
  path, page = tuple
  trimmed_target = join(split(target, "/")[1:(end - 1)], "/")
  new_target = joinpath(trimmed_target, path)
  if new_target[(end - 4):end] != ".html"
    new_target *= ".html"
  end
  return parse_julia_page(source, new_target, page, verbose)
end

function parse_julia_page(
  source,
  target,
  vector::Vector{<:Tuple{<:String, <:HTMLElement}},
  verbose = false,
)
  return map(s -> parse_julia_page(source, target, s, verbose), vector)
end
