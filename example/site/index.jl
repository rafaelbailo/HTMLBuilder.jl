HTMLDoc(
  DOCTYPE(),
  html(
    (; lang = "en"),
    head(title("Main Page")),
    body(
      h1("Main Page"),
      p(
        "This is the main page of the example site. You can explore the following:",
      ),
      ul(
        li("Simple examples:"),
        ul(
          li(a((; href = "/simple/fibonacci.html"), "The Fibonacci numbers")),
          li(a((; href = "/simple/assets.html"), "A page with assets")),
          li(a((; href = "/simple/redirection.html"), "A redirection page")),
        ),
        li("Advanced examples:"),
        ul(
          li(
            a(
              (; href = "/advanced/another_folder/another_path.html"),
              "A page with a custom path",
            ),
          ),
          li(
            "The ",
            a(
              (;
                href = "https://en.wikipedia.org/wiki/Generalizations_of_Fibonacci_numbers#Tribonacci_numbers"
              ),
              "Tribonacci numbers",
            ),
            ", each on its own page:",
          ),
          ul([
            li(
              a(
                (; href = "/advanced/tribonacci/$(n).html"),
                "The n = $(n) Tribonacci number",
              ),
            ) for n ∈ 1:20
          ]),
        ),
      ),
    ),
  ),
)
