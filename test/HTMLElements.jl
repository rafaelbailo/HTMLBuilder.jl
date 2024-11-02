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
end

tests()
