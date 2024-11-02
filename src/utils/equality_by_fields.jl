macro equality_by_fields(type)
  return :(
    function Base.:(==)(a::$(esc(type)), b::$(esc(type)))
      return all(
        getfield(a, sym) == getfield(b, sym) for sym ∈ fieldnames($(esc(type)))
      )
    end
  )
end
