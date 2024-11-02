using HTMLBuilder

using SafeTestsets, Test

@testset "HTMLBuilder.jl" begin
  for test ∈ ["aqua", "format", "HTMLElements", "utils"]
    @eval begin
      @safetestset $test begin
        include($test * ".jl")
      end
    end
  end
end
