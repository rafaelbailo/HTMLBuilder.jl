macro register(element)
  return esc(
    quote
      $element(args...) = HTMLElement(Val($(Meta.quot(element))), args...)
      const $(Symbol(element, :Val)) = Val{$(Meta.quot(element))}
      const $(Symbol(element, :Type)) = HTMLElement{$(Symbol(element, :Val))}
    end,
  )
end

export @register

macro register(elements...)
  return Expr(:block, map(s -> esc(quote
    @register($(s))
  end), elements)...)
end
