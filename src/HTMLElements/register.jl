macro register(element)
  return esc(
    quote
      $element(args...) = HTMLElement(Val($(Meta.quot(element))), args...)
      const $(Symbol(element, :Type)) = HTMLElement{Val{$(Meta.quot(element))}}
    end,
  )
end

macro register(elements...)
  return Expr(:block, map(s -> esc(quote
    @register($(s))
  end), elements)...)
end
