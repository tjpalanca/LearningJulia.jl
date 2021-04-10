# Javis.jl - Tutorial 5 

using Javis
using PeriodicTable
using Animations
using Unitful

function ground(video, action, frame)
    background("white")
    sethue("black")
end

function element(; radius = 1, color = "black")
    sethue(color)
    circle(O, radius + 4, :fill) # The 4 is to make the circle not so small
end

function info_box(element)
    fontsize(12)
    box(140, -210, 170, 40, :stroke)
    box(0, 175, 450, 100, :stroke)
    text("Element name: $(element.name)", 140, -220, valign = :middle, halign = :center)
    text(
        "Atomic Mass: $(round(ustrip(element.atomic_mass)))",
        140,
        -200,
        valign = :middle,
        halign = :center,
    )
    textwrap("Description: $(element.summary)", 400, Point(-200, 125))
end

demo = Video(500, 500)
Background(1:550, ground)

atom = Object(1:550, (args...; radius = 1) -> element(; radius = radius, color = "black"))

act!(
    atom,
    [
        Action(101:140, change(:radius, 1 => 12)),
        Action(241:280, change(:radius, 12 => 20)),
        Action(381:420, change(:radius, 20 => 7)),
        Action(521:550, change(:radius, 7 => 1)),
    ],
)

info = Object(1:550, (args...; elem = 1) -> info_box(elements[round(Int, elem)]))

act!(info, Action(1:30, sineio(), appear(:fade)))
act!(info, Action(71:100, sineio(), disappear(:fade)))
act!(info, Action(101:101, change(:elem, 1 => 12)))

act!(info, Action(140:170, sineio(), appear(:fade)))
act!(info, Action(210:241, sineio(), disappear(:fade)))
act!(info, Action(280:280, change(:elem, 12 => 20)))

act!(info, Action(280:310, sineio(), appear(:fade)))
act!(info, Action(350:381, sineio(), disappear(:fade)))
act!(info, Action(381:420, change(:elem, 20 => 7)))

act!(info, Action(420:450, sineio(), appear(:fade)))
act!(info, Action(490:521, sineio(), disappear(:fade)))
act!(info, Action(520:550, change(:elem, 7 => 1)))

render(demo, pathname=joinpath(tempdir(), "tutorial5.gif"), framerate = 10)