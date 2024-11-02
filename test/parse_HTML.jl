using HTMLBuilder, Test

parse_test(el) = @test string(HTMLDoc(el)) == string(parse_HTML(string(el)))

function tests()
  @testset "tags" begin
    for el ∈ [
      dv(),
      dv(dv()),
      dv(dv(dv(), dv())),
      dv(dv(dv(h1("Title")), dv())),
      dv(dv(dv(h1("Title")), dv(p("Text")))),
      collection(dv("Text"), "Comment", dv("More text")),
      dv(collection(dv("Text"), dv("More text"))),
      dv(collection(dv((; class = "Class"), "Text"), dv("More text"))),
      iframe((;
        src = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d39520.79839516039!2d-1.2826071108704211!3d51.75041109690968!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x48713380adc41faf%3A0xc820dba8cb547402!2sOxford!5e0!3m2!1sen!2suk!4v1679934775291!5m2!1sen!2suk"
      )),
    ]
      parse_test(el)
    end
  end
end

tests()
