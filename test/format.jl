using HTMLBuilder, JuliaFormatter, Test

function tests()
  f(s) = format(s; HTMLBuilder.FORMAT_SETTINGS...)
  f("..")
  @test f("..")
end

tests()
