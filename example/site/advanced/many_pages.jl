Fibonacci(n::Int) = (n <= 2) ? (1) : (Fibonacci(n - 1) + Fibonacci(n - 2))

[
  (
    "fibonacci/$n",
    HTMLDoc(
      DOCTYPE(),
      html(
        (; lang = "en"),
        head(title("Fibonacci Numbers")),
        body(
          h1("The $(n)th Fibonacci Number"),
          p("The $(n)th fibonacci number is $(Fibonacci(n))."),
        ),
      ),
    ),
  ) for n ∈ 1:20
]
