# Compose.jl

using Compose

tomato_bisque =
    compose(context(),
            (context(), circle(), fill("bisque")),
            (context(), rectangle(), fill("tomato")))

introspect(tomato_bisque)

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

# Javis.jl - Tutorial 1

using Javis

function ground(args...) 
    background("white") # canvas background
    sethue("black") # pen color
end

function object(p=O, color="black")
    sethue(color)
    circle(p, 25, :fill)
    return p
end

function path!(points, pos, color) 
    sethue(color)
    push!(points, pos)
    circle.(points, 2, :fill)
end

function connector(p1, p2, color)
    sethue(color)
    line(p1,p2, :stroke)
end

myvideo = Video(500,500)

path_of_red = Point[]
path_of_blue = Point[]
Background(1:70, ground)
red_ball = Object(1:70, (args...) -> object(O, "red"), Point(100, 0))
act!(red_ball, Action(anim_rotate_around(2π, O)))
Object(1:70, (args...) -> path!(path_of_red, pos(red_ball), "red"))

blue_ball = Object(1:70, (args...)-> object(O, "blue"), Point(200,80))
act!(blue_ball, Action(anim_rotate_around(2π, 0.0, red_ball)))
Object(1:70, (args...) -> path!(path_of_blue, pos(blue_ball), "blue"))

Object(1:70, (args...) -> connector(pos(red_ball), pos(blue_ball), "black"))

render(
    myvideo;
    pathname = "circle.gif"
)


