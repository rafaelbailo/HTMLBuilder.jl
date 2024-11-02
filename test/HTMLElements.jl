using HTMLBuilder, Test

function tests()
  @testset "tags" begin
    @test HTMLBuilder.open_tag(:a) == "<a>"
    @test HTMLBuilder.close_tag(:a) == "</a>"
    @test HTMLBuilder.open_tag(:div) == "<div>"
    @test HTMLBuilder.close_tag(:div) == "</div>"
    @test HTMLBuilder.tag(:DOCTYPE, left_exclamation = true) == "<!DOCTYPE>"
    @test HTMLBuilder.tag(:img, (; src = "#", alt = "image")) ==
          "<img src='#' alt='image'>"
  end

  @testset "construction and equality" begin
    for f ∈ [
      () -> dv(),
      () -> dv(dv()),
      () -> dv(dv(dv(), dv())),
      () -> dv(dv(dv(h1("Title")), dv())),
      () -> dv(dv(dv(h1("Title")), dv(p("Text")))),
    ]
      @test f() == f()
    end
  end

  @testset "show" begin
    for el ∈ [
      HTMLElement(Val(:div), NamedTuple(), ["test"], (; indent = false)),
      HTMLElement(Val(:div), ["test"], (; indent = false)),
      HTMLElement(Val(:div), NamedTuple(), "test", (; indent = false)),
      HTMLElement(Val(:div), "test", (; indent = false)),
    ]
      @test string(el) == *("<div>", "test", "</div>")
    end

    for el ∈ [
      HTMLElement(Val(:div), NamedTuple(), ["test"]),
      HTMLElement(Val(:div), ["test"]),
      HTMLElement(Val(:div), NamedTuple(), "test"),
      HTMLElement(Val(:div), "test"),
    ]
      @test string(el) == *("<div>", "\n", "  ", "test", "\n", "</div>")
    end

    el = dv()
    @test string(el) == *("<div>", "</div>")

    el = dv(dv())
    @test string(el) ==
          *("<div>", "\n", "  ", "<div>", "</div>", "\n", "</div>")

    el = dv(dv(dv(), dv()))
    @test string(el) == *(
      "<div>",
      "\n",
      "  ",
      "<div>",
      "\n",
      "  ",
      "  ",
      "<div>",
      "</div>",
      "\n",
      "  ",
      "  ",
      "<div>",
      "</div>",
      "\n",
      "  ",
      "</div>",
      "\n",
      "</div>",
    )

    el = dv(dv(dv(h1("Title")), dv()))
    @test string(el) == *(
      "<div>",
      "\n",
      "  ",
      "<div>",
      "\n",
      "  ",
      "  ",
      "<div>",
      "\n",
      "  ",
      "  ",
      "  ",
      "<h1>",
      "Title",
      "</h1>",
      "\n",
      "  ",
      "  ",
      "</div>",
      "\n",
      "  ",
      "  ",
      "<div>",
      "</div>",
      "\n",
      "  ",
      "</div>",
      "\n",
      "</div>",
    )

    el = dv(dv(dv(h1("Title")), dv(p("Text"))))
    @test string(el) == *(
      "<div>",
      "\n",
      "  ",
      "<div>",
      "\n",
      "  ",
      "  ",
      "<div>",
      "\n",
      "  ",
      "  ",
      "  ",
      "<h1>",
      "Title",
      "</h1>",
      "\n",
      "  ",
      "  ",
      "</div>",
      "\n",
      "  ",
      "  ",
      "<div>",
      "\n",
      "  ",
      "  ",
      "  ",
      "<p>",
      "Text",
      "</p>",
      "\n",
      "  ",
      "  ",
      "</div>",
      "\n",
      "  ",
      "</div>",
      "\n",
      "</div>",
    )
  end
end

tests()
