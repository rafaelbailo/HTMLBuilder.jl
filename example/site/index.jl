HTMLDoc(
  DOCTYPE(),
  html(
    (; lang = "en"),
    head(title("Main Page")),
    body(
      h1("Main Page"),
      p("This is the main page."),
      ul(li(a((; href = "/simple_pages/fibonacci.html"), "Fibonacci"))),
    ),
  ),
)
