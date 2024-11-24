HTMLDoc(
  DOCTYPE(),
  html(
    (; lang = "en"),
    head(title("Loading Assets")),
    body(
      h1("Loading Assets"),
      p("This page loads HTMLBuilder.jl's logo from the assets folder:"),
      img((; width = "100%", src = "./logos/logo-large.svg")),
    ),
  ),
)
