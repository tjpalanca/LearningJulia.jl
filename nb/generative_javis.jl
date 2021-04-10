### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# ╔═╡ 05dd527e-99e3-11eb-0dcd-b5e1d2804d22
using Javis

# ╔═╡ b4a7330b-4905-4484-9fb7-5b01307e7a47
myvideo = Video(500, 500)

# ╔═╡ da1ae934-105b-4a9b-a90a-0648710c229a
function ground(args...) 
    background("white") # canvas background
    sethue("black") # pen color
end

# ╔═╡ 88ee084c-94af-435c-9b65-ebb61dee3938
function object(p=Point(0,0), color="black")
    sethue(color)
    circle(p, 25, :fill)
    return p
end

# ╔═╡ 2a2ef4ae-3a39-4410-9f4f-c754c4fa82b4
begin	
	Background(1:70, ground)
	red_ball = Object(1:70, (args...) -> object(O, "red"), Point(100, 0))
	render(myvideo; tempdirectory = tempdir(), pathname = "circle.gif")
end

# ╔═╡ Cell order:
# ╠═05dd527e-99e3-11eb-0dcd-b5e1d2804d22
# ╠═b4a7330b-4905-4484-9fb7-5b01307e7a47
# ╠═da1ae934-105b-4a9b-a90a-0648710c229a
# ╠═88ee084c-94af-435c-9b65-ebb61dee3938
# ╠═2a2ef4ae-3a39-4410-9f4f-c754c4fa82b4
