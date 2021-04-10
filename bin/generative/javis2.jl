# Javis.jl tutorial 2

using Javis
using Random

video = Video(500, 500)
anim_background = Background(1:10, ground)

function ground(args...)
    background("white")
    sethue("black")
end

function circ(p=O, color="black", action=:fill, radius=25, edge="solid")
    sethue(color)
    setdash(edge)
    circle(p, radius, action)
end 

function draw_line(p1=O, p2=O, color="black", action=:stroke, edge="solid")
    sethue(color)
    setdash(edge)
    line(p1, p2, action)
end 

function electrode(p=O, fill_color="white", outline_color="black", action=:fill,
    radius=25, circ_text="")
    sethue(fill_color)
    circle(p, radius, :fill)
    sethue(outline_color)
    circle(p, radius, :stroke)
    text(circ_text, p, valign = :middle, halign = :center)
end

function info_box(video, object, frame)
    fontsize(12)
    box(140, -210, 170, 40, :stroke)
    text("10-20 EEG Array Readings", 140, -220, valign = :middle, halign = :center)
    text("t = $(frame)s", 140, -200, valign = :middle, halign = :center)
end

head = Object((args...) -> circ(O, "black", :stroke, 170))
inside_circle = Object((args...) -> circ(O, "black", :stroke, 140, "longdashed"))
vert_axis = Object(
    (args...) -> 
        draw_line(Point(0, -170), Point(0, 170), "black", :stroke, "longdashed")
)
hori_axis = Object(
    (args...) ->
        draw_line(Point(170, 0), Point(-170, 0), "black", :stroke, "longdashed")
)

electrodes_list = [
    (name = "Cz", position = O),
    (name = "C3", position = Point(-70, 0)),
    (name = "C4", position = Point(70, 0)),
    (name = "T3", position = Point(-140, 0)),
    (name = "T4", position = Point(140, 0)),
    (name = "Pz", position = Point(0, 70)),
    (name = "P3", position = Point(-50, 70)),
    (name = "P4", position = Point(50, 70)),
    (name = "Fz", position = Point(0, -70)),
    (name = "F3", position = Point(-50, -70)),
    (name = "F4", position = Point(50, -70)),
    (name = "F8", position = Point(115, -80)),
    (name = "F7", position = Point(-115, -80)),
    (name = "T6", position = Point(115, 80)),
    (name = "T5", position = Point(-115, 80)),
    (name = "Fp2", position = Point(40, -135)),
    (name = "Fp1", position = Point(-40, -135)),
    (name = "A1", position = Point(-190, -10)),
    (name = "A2", position = Point(190, -10)),
    (name = "O1", position = Point(-40, 135)),
    (name = "O2", position = Point(40, 135)),
]

indicators = ["white", "gold1", "darkolivegreen1", "tomato"]

radius = 15 
for num in 1:length(electrodes_list)
    Object(
        (args...) ->
            electrode.(
                electrodes_list[num].position,
                rand(indicators, length(electrodes_list)),
                "black",
                :fill,
                radius,
                electrodes_list[num].name,
            ),
    )
end

info = Object(info_box)

render(
    video;
    pathname=joinpath(tempdir(), "eeg.gif"), 
    framerate=1
)