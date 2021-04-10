# Javis.jl - Tutorial 4 

using Javis

function ground(args...)
    background("white")
    sethue("black")
end

function title(args...)
    fontsize(20)
    text("Our Mascot", Point(0, -200),
        valign=:middle, halign=:center)
end

function hair_blob(angle)
    sethue("brown")
    rotate(angle)
    circle(Point(0, -100), 20, :fill)
end

function eyes(centers, radius, color)
    sethue(color)
    circle.(centers, radius, :fill)
    setcolor("white")
    circle.(centers, radius/5, :fill)
end

function speak(str)
    fontsize(15)
    text(str, Point(100, 50))
end

function lip(p1, p2)
    setline(2)
    move(p1)
    c1 = p1 + Point(10, 10)
    c2 = p2 + Point(-10, 10)
    curve(c1, c2, p2)
    do_action(:stroke)
end

function face()
    video = Video(500, 500)
    Background(1:150, ground)
    the_title = Object(title)
    act!(the_title, Action(1:5, appear(:fade)))
    head = Object(16:150, (args...) -> circle(O, 100, :stroke))
    act!(head, Action(1:15, appear(:fade)))
    hair_angle = rand(-0.9:0.1:0.9, 20)
    hair = Object[]
    for i = 1:20
        push!(hair, Object(26:150, (args...)->hair_blob(hair_angle[i])))
    end
    act!(hair, Action(1:25, appear(:fade)))
    eye_centers = [Point(-40,-30), Point(40,-30)]
    nose = [O, Point(-10,20), Point(10, 20), O]
    the_eyes = Object(30:150, (args...)->eyes(eye_centers, 10, "darkblue"))
    act!(the_eyes, Action(1:15, appear(:fade)))
    the_nose = Object(45:150, (args...)->poly(nose, :fill))
    act!(the_nose, Action(1:15, appear(:fade)))
    upper_lip = [Point(-40, 45), Point(40, 45)]
    lower_lip = [Point(-40, 55), Point(40, 55)]
    lip_fade_in = Action(1:15, appear(:fade))
    the_upper_lip = Object(60:150, (args...)->lip(upper_lip...))
    act!(the_upper_lip, lip_fade_in)
    act!(the_upper_lip, [Action(20i:20i+10, anim_translate(0, -5)) for i in 1:5])
    act!(the_upper_lip, [Action(20i+10:20i+20, anim_translate(0, 5)) for i in 1:5])
    the_lower_lip = Object(60:150, (args...)->lip(lower_lip...))
    act!(the_lower_lip, lip_fade_in)
    act!(the_lower_lip, [Action(20i:20i+10, anim_translate(0, 5)) for i in 1:5])
    act!(the_lower_lip, [Action(20i+10:20i+20, anim_translate(0, -5)) for i in 1:5])
    speaking1 = Object(80:120, (args...)->speak("I'm Jarvis"))
    act!(speaking1, Action(1:5, appear(:draw_text)))
    act!(speaking1, Action(36:40, disappear(:draw_text)))

    speaking2 = Object(120:150, (args...)->speak("How are you?"))
    act!(speaking2, Action(1:5, appear(:draw_text)))
    act!(speaking2, Action(36:40, disappear(:draw_text)))  
    render(video; pathname=joinpath(tempdir(), "jarvis.gif"), framerate=15)
end

face()