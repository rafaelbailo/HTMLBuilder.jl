using HTMLBuilder

using SafeTestsets, Test

@testset "HTMLBuilder.jl" begin
  for test ∈ ["utils", "aqua", "format"]
    @eval begin
      @safetestset $test begin
        include($test * ".jl")
      end
    end
  end
end
