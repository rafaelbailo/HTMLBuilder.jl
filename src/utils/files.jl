extension(s) = split(s, ".")[end];

get_assets_path(dir, config) = joinpath(dir, config.assets_path)

get_dist_path(dir, config) = joinpath(dir, config.dist_path)

get_site_path(dir, config) = joinpath(dir, config.site_path)

function get_build_path(root, dist_path, target_path, head)
  return joinpath(replace(root, target_path => dist_path), head)
end

function reset_dir(dir, verbose = false)
  @verbose_print "\n--> Resetting directory $(dir)..." verbose
  mkpath(dir)
  for p ∈ readdir(dir)
    rm(joinpath(dir, p), force = true, recursive = true)
  end
  return nothing
end

function copy_assets(dist_path, assets_path, verbose = false)
  if isdir(assets_path)
    @verbose_print "\n--> Copying assets..." verbose
    for el ∈ readdir(assets_path)
      source = joinpath(assets_path, el)
      target = joinpath(dist_path, el)
      println("Copying $target.")
      cp(source, target)
    end
  end
end
