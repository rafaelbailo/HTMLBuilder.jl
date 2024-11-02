using HTMLBuilder, Test

struct DummyStruct
  vec::Vector{Float64}
end

HTMLBuilder.@equality_by_fields DummyStruct

function tests()
  @testset "check_key" begin
    tuple1 = (; first = true, second = true)
    tuple2 = (; first = true, second = false)
    tuple3 = (; first = true)
    tuple4 = (; first = false, second = true)
    tuple5 = (; first = false, second = false)
    tuple6 = (; first = false)

    @test HTMLBuilder.check_key(tuple1, :first)
    @test HTMLBuilder.check_key(tuple1, :second)

    @test HTMLBuilder.check_key(tuple2, :first)
    @test !HTMLBuilder.check_key(tuple2, :second)

    @test HTMLBuilder.check_key(tuple3, :first)
    @test !HTMLBuilder.check_key(tuple3, :second)

    @test !HTMLBuilder.check_key(tuple4, :first)
    @test HTMLBuilder.check_key(tuple4, :second)

    @test !HTMLBuilder.check_key(tuple5, :first)
    @test !HTMLBuilder.check_key(tuple5, :second)

    @test !HTMLBuilder.check_key(tuple6, :first)
    @test !HTMLBuilder.check_key(tuple6, :second)
  end

  @testset "@equality_by_fields" begin
    vec1 = rand(3)
    vec2 = rand(3)

    struct1 = DummyStruct(vec1)
    struct2 = DummyStruct(vec2)
    struct3 = DummyStruct(vec1)

    @test struct1 != struct2
    @test struct1 == struct3
    @test struct2 != struct3
  end
end

tests()
