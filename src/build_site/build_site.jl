macro build_site(dir = ".", config = NamedTuple())
  return esc(quote
    config = merge(HTMLBuilder.DEFAULT_BUILD_SITE_CONFIG, $config)
    verbose = HTMLBuilder.check_key(config, :verbose)
    HTMLBuilder.@verbose_print_config "\n====> Building site..."

    assets_path = HTMLBuilder.get_assets_path($dir, config)
    dist_path = HTMLBuilder.get_dist_path($dir, config)
    site_path = HTMLBuilder.get_site_path($dir, config)

    HTMLBuilder.reset_dir(dist_path, verbose)

    HTMLBuilder.copy_assets(dist_path, assets_path, verbose)

    HTMLBuilder.@buildPages dist_path site_path

    HTMLBuilder.@verbose_print_config "\n====> Site complete!"
  end)
end
export @build_site

macro buildPages(dist_path, site_path)
  return esc(
    quote
      if isdir(site_path)
        HTMLBuilder.@verbose_print "\n--> Building pages..." verbose

        sitemap = String[]

        for (root, dirs, files) ∈ walkdir($site_path)
          for file ∈ files
            ex, source, target = HTMLBuilder.get_extension_source_and_target(
              root,
              file,
              $dist_path,
              $site_path,
            )

            if ex == "jl"
              parsed_target = nothing
              #               HTMLBuilder.@parseJuliaPage source target
            elseif ex == "txt"
              HTMLBuilder.@parse_redirection_page source target verbose
            end

            mapUrl = HTMLBuilder.get_sitemap_url(parsed_target, dist_path)
            HTMLBuilder.push_several!(sitemap, mapUrl)
          end
        end

        HTMLBuilder.make_sitemap(sitemap, $dist_path)
      end
    end,
  )
end

function get_extension_source_and_target(root, file, dist_path, site_path)
  ex = extension(file)
  source = joinpath(root, file)
  target = get_build_path(
    root,
    dist_path,
    site_path,
    replace(file, ("." * ex) => ".html"),
  )
  return ex, source, target
end

# macro parseJuliaPage(source, target)
#   return esc(quote
#     page = include(source)
#     parsed_target = HTMLBuilder.parseJuliaPage(source, target, page)
#   end)
# end

# parseJuliaPage(source, target, page::Nothing) = nothing;

# function parseJuliaPage(source, target, page::HTMLElement)
#   println("    Building $target.")

#   mkpath(dirname(target))
#   open(target, "w") do f
#     write(f, comment(" $(HTMLBuilder.HTMLBuilder_SIGNATURE) "))
#     return write(f, page)
#   end
#   return target
# end

# function parseJuliaPage(source, target, tuple::Tuple{<:String, <:HTMLElement})
#   path, page = tuple
#   trimmedTarget = join(split(target, "/")[1:(end - 1)], "/")
#   newTarget = joinpath(trimmedTarget, path)
#   if newTarget[(end - 4):end] != ".html"
#     newTarget *= ".html"
#   end
#   return parseJuliaPage(source, newTarget, page)
# end

# function parseJuliaPage(
#   source,
#   target,
#   vector::Vector{<:Tuple{<:String, <:HTMLElement}},
# )
#   return map(s -> parseJuliaPage(source, target, s), vector)
# end
