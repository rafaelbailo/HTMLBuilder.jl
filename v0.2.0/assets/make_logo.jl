using Luxor

# for extension ∈ ["png", "svg"]
for extension ∈ ["svg"]
  for (suffix, main_color) ∈ [("", "black"), ("dark", "white")]
    for mode ∈ ["regular", "large"]
      R = 500

      width, height = 4 * R, 0.6 * R

      file_mode = (mode == "regular") ? "" : "-" * mode
      file_suffix = (suffix == "") ? "" : "-" * suffix
      file = "logo$(file_mode)$(file_suffix).$(extension)"

      Drawing(width, height, file)
      origin()

      fontface("Fira Code")
      fontsize(0.38 * R)

      setline(4)

      setcolor(main_color)

      text("<", Point(-1.871 * R, 0.12 * R), halign = :center)
      text("Builder jl/>", Point(0.585 * R, 0.12 * R), halign = :center)

      if mode == "large"
        setcolor(Luxor.julia_blue)
        textoutlines("H", Point(-1.639 * R, 0.12 * R), halign = :center)
        fillpreserve()
        sethue(main_color)
        strokepath()

        setcolor(Luxor.julia_green)
        textoutlines("T", Point(-1.404 * R, 0.12 * R), halign = :center)
        fillpreserve()
        sethue(main_color)
        strokepath()

        setcolor(Luxor.julia_purple)
        textoutlines("M", Point(-1.17 * R, 0.12 * R), halign = :center)
        fillpreserve()
        sethue(main_color)
        strokepath()

        setcolor(Luxor.julia_red)
        textoutlines("L", Point(-0.937 * R, 0.12 * R), halign = :center)
        fillpreserve()
        sethue(main_color)
        strokepath()
      else
        setcolor(Luxor.julia_blue)
        text("H", Point(-1.639 * R, 0.12 * R), halign = :center)

        setcolor(Luxor.julia_green)
        text("T", Point(-1.404 * R, 0.12 * R), halign = :center)

        setcolor(Luxor.julia_purple)
        text("M", Point(-1.17 * R, 0.12 * R), halign = :center)

        setcolor(Luxor.julia_red)
        text("L", Point(-0.937 * R, 0.12 * R), halign = :center)
      end

      translate(0.937 * R, 0.088 * R)
      juliacircles(0.05 * R)
      setcolor("blue")
      circle(Point(0.26 * R, -0.245 * R), 0.038 * R, action = :fill)

      finish()
    end
  end
end
