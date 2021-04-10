# Luxor.jl

using Luxor
using Colors

@draw begin 
    text("Hello world")
    circle(Point(0, 0), 200, :stroke)
end

@draw begin 
    text("Hello again, world!", Point(0, 250))
    circle(Point(0, 0), 200, :fill)
    rulers()
end

# Drawing Euclidean Circles
@draw begin 
    radius = 80
    setdash("dot")
    sethue("orange1")
    A, B = [Point(x, 0) for x in [-radius, radius]]
    line(A, B, :stroke)
    circle(O, radius, :stroke),
    label("A", :NW, A)
    label("O", :N, O)
    label("B", :NE, B)
    circle.([A, O, B], 2, :fill)
    circle.([A, B], 2 * radius, :stroke)
end

# Trying to find intersections
@draw begin 
    radius = 80
    setdash("dot")
    sethue("orange1")
    A, B = [Point(x, 0) for x in [-radius, radius]]
    line(A, B, :stroke)
    circle(O, radius, :stroke),
    label("A", :NW, A)
    label("O", :N, O)
    label("B", :NE, B)
    circle.([A, O, B], 2, :fill)
    circle.([A, B], 2 * radius, :stroke)
end
