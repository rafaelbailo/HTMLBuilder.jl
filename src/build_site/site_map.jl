get_sitemap_url(target::Nothing, dist_path) = "";

function get_sitemap_url(target::String, dist_path)
  return String(split(target, dist_path)[end])
end

function get_sitemap_url(target::Vector{String}, dist_path)
  return map(s -> get_sitemap_url(s, dist_path), target)
end

push_several!(v::Vector{T}, x::T) where {T} = push!(v, x)

push_several!(v::Vector{T}, x::Vector{T}) where {T} = append!(v, x)

function make_sitemap(sitemap, dist_path)
  sitemap_target = joinpath(dist_path, "sitemap.txt")
  open(sitemap_target, "w") do f
    for site ∈ sitemap
      if site != ""
        println(f, site)
      end
    end
  end
end
