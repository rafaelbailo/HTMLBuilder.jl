function Fibonacci(n::Int)
  return (n <= 2) ? (1 * (n == 2)) : (Fibonacci(n - 1) + Fibonacci(n - 2))
end

HTMLDoc(
  DOCTYPE(),
  html(
    (; lang = "en"),
    head(title("Fibonacci Numbers")),
    body(
      h1("Fibonacci Numbers"),
      h2("Automatically generated by Julia"),
      p(
        "Here are the first 20 ",
        a(
          (; href = "https://en.wikipedia.org/wiki/Fibonacci_sequence"),
          "Fibonacci numbers",
        ),
        ":",
      ),
      ul([li(string(Fibonacci(n))) for n ∈ 1:20]),
    ),
  ),
)