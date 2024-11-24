using Luxor

R = 500

width, height = 0.6 * R, 0.6 * R

file = "favicon.png"

Drawing(width, height, file)
origin()

fontface("Fira Code")
fontsize(0.38 * R)

setline(4)

setcolor("black")
textoutlines("<", Point(-0.17 * R, 0.12 * R), halign = :center)
fillpreserve()
sethue("white")
strokepath()

setcolor("black")
textoutlines(">", Point(+0.17 * R, 0.12 * R), halign = :center)
fillpreserve()
sethue("white")
strokepath()

juliacircles(0.05 * R)

finish()

using Images

save("favicon.ico", imresize(load("favicon.png"), 64, 64))
