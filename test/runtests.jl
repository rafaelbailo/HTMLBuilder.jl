using HTMLBuilder

using SafeTestsets, Test

@testset "HTMLBuilder.jl" begin
  for test ∈ ["aqua", "format", "HTMLElements", "parse_HTML", "utils"]
    @eval begin
      @safetestset $test begin
        include($test * ".jl")
      end
    end
  end
end
