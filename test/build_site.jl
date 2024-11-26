using HTMLBuilder, Test

tests() = @test_nowarn @build_site "../example"

tests()
