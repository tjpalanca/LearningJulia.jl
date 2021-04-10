# Javis.jl - Tutorial 3

using Javis, LaTeXStrings

my_latex_string = L"9\frac{3}{4}"

function ground(args...)
    background("white")
    sethue("black")
end

function draw_latex(video, action, frame)
    translate(video.width / -2, video.height / -2)
    fontsize(50)
    black_red = blend(O, Point(0, 150), "black", "red")
    setblend(black_red)
    latex(
        L"""\begin{equation}
        \left[\begin{array}{cc} 
        2 & 3 \\  4 & \sqrt{5} \\  
        \end{array} \right] 
        \end{equation}"""
    )
end

demo = Video(300, 200)
Background(1:1, ground)
Object(draw_latex)

render(
    demo;
    pathname = joinpath(tempdir(), "latex.gif"),
    framerate = 1
)