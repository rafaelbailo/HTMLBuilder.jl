check_key(tuple, key) = haskey(tuple, key) && getfield(tuple, key)

macro verbose_print(text, bool)
  call = Expr(:call, :println, text)
  conditional = esc(Expr(:if, bool, call))
  return conditional
end

macro verbose_print_config(text)
  condition = Expr(:call, check_key, :config, Meta.quot(:verbose))
  call = esc(
    Expr(
      :macrocall,
      :(HTMLBuilder.var"@verbose_print"),
      nothing,
      text,
      condition,
    ),
  )
  return call
end
