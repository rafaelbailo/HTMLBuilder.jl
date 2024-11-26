function Tribonacci(n::Int)
  return if (n <= 3)
    (1 * (n >= 2))
  else
    (Tribonacci(n - 1) + Tribonacci(n - 2) + Tribonacci(n - 3))
  end
end

[
  (
    "tribonacci/$n",
    HTMLDoc(
      DOCTYPE(),
      html(
        (; lang = "en"),
        head(title("Tribonacci Numbers")),
        body(
          h1("The n = $(n) Tribonacci Number"),
          p(
            "The n = $(n) ",
            a(
              (;
                href = "https://en.wikipedia.org/wiki/Generalizations_of_Fibonacci_numbers#Tribonacci_numbers"
              ),
              "Tribonacci number",
            ),
            " is $(Tribonacci(n)).",
          ),
        ),
      ),
    ),
  ) for n ∈ 1:20
]
