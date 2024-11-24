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
              HTMLBuilder.@parse_julia_page source target verbose
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
