macro parse_redirection_page(source, target, verbose)
  return esc(
    quote
      url = read(source, String)
      parsed_target =
        HTMLBuilder.parse_redirection_page(source, target, url, verbose)
    end,
  )
end

parse_redirection_page(source, target, url::Nothing, verbose) = nothing;

function parse_redirection_page(source, target, url, verbose = false)
  @verbose_print "Building $target." verbose
  page = redirection_page(url)

  mkpath(dirname(target))
  open(target, "w") do f
    write(f, comment(" $(HTMLBuilder.HTMLBuilder_SIGNATURE) "))
    write(f, page)
    return nothing
  end
  return target
end

function redirection_page(url)
  return HTMLDoc(
    DOCTYPE(),
    html(
      (; lang = "en"),
      head(meta((; Symbol("http-equiv") => "refresh", content = "0; " * url))),
      body(p("Redirecting to ", a((; href = url), url), ".")),
    ),
  )
end
