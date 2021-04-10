### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# ╔═╡ 4db71ce9-4b21-4169-9f00-b763a36de8bc
using Luxor, PlutoUI, Colors

# ╔═╡ aff7ee1a-99aa-11eb-0901-bdf031382d27
md"""
# Trying Luxor.jl

This is a sample notebook for trying out the generative art capabilities of Luxor.jl.
"""

# ╔═╡ b0c23bbf-5c95-42fa-a6a8-40011eb45723
@draw begin
	radius=80
    setdash("dot")
    sethue("orange3")
    A, B = [Point(x, 0) for x in [-radius, radius]]
    line(A, B, :stroke)
    circle(Point(0, 0), radius, :stroke)
    label("A", :NW, A)
    label("O", :N,  O)
    label("B", :NE, B)
    circle.([A, O, B], 2, :fill)
    circle.([A, B], 2radius, :stroke)
	# Getting the intersection of the circles
	nints, C, D =
		intersectionlinecircle(
			Point(0, -2radius),
			Point(0, +2radius),
			A,
			2radius
		)
	if nints == 2
		circle.([C, D], 2, :fill)
		label.(["D", "C"], :N, [D, C])
	end
	nints, C1, C2 = intersectionlinecircle(O, D, O, radius)
	if nints == 2
		circle(C1, 3, :fill)
		label("C1", :N, C1)
	end
	nints, I3, I4 = intersectionlinecircle(A, C1, A, 2radius)
	nints, I1, I2 = intersectionlinecircle(B, C1, B, 2radius)
	circle.([I1, I2, I3, I4], 2, :fill)
	if distance(C1, I3) < distance(C1, I2)
		ip1 = I1
	else 
		ip1 = I2
	end
	if distance(C1, I3) < distance(C1, I4)
		ip2 = I3
	else 
		ip2 = I4
	end
	label("ip1", :N, ip1)
	label("ip2", :N, ip2)
	circle(C1, distance(C1, ip1), :stroke)
	setline(5)
	setdash("solid")
	arc2r(B, A, ip1, :path)
	arc2r(C1, ip1, ip2, :path)
	arc2r(A, ip2, B, :path)
	arc2r(O, B, A, :path)
	strokepreserve()
	setopacity(0.8)
	sethue("ivory")
	fillpath()
end

# ╔═╡ 18bc00c5-67af-429f-aa99-73f39c1056bf
function egg(radius, action=:none)
    A, B = [Point(x, 0) for x in [-radius, radius]]
    nints, C, D =
        intersectionlinecircle(Point(0, -2radius), Point(0, 2radius), A, 2radius)

    flag, C1 = intersectionlinecircle(C, D, O, radius)
    nints, I3, I4 = intersectionlinecircle(A, C1, A, 2radius)
    nints, I1, I2 = intersectionlinecircle(B, C1, B, 2radius)

    if distance(C1, I1) < distance(C1, I2)
        ip1 = I1
    else
        ip1 = I2
    end
    if distance(C1, I3) < distance(C1, I4)
        ip2 = I3
    else
        ip2 = I4
    end

    newpath()
    arc2r(B, A, ip1, :path)
    arc2r(C1, ip1, ip2, :path)
    arc2r(A, ip2, B, :path)
    arc2r(O, B, A, :path)
    closepath()

    do_action(action)
end

# ╔═╡ 62dc9062-e933-47df-bb8d-d18e2007cc2d
eggrange = range(0, step=π/6, length=12)

# ╔═╡ 06b7532d-9a4c-4f37-9819-4877dc631a22
eggtrans = (0, -150)

# ╔═╡ 9c19bc63-792a-4d20-a46b-7f8150a53d8e
@draw begin
    setopacity(0.7)
    for θ in eggrange
		# @layer allows us to make temporary changes to the drawing environment 
		# i.e. isolate a layer of things
        @layer begin
            rotate(θ)
            translate(eggtrans...)
            egg(50, :path)
            setline(10)
            randomhue()
            fillpreserve()
            randomhue()
            strokepath()
			display(getrotation())
			display(getscale())
        end
    end
end 

# ╔═╡ 2e305d05-6125-45b5-884b-52596148cf77
@draw begin
	setlinejoin("round")
	egg(160, :path)
	pgon = first(pathtopoly())
	pc = polycentroid(pgon)
	circle(pc, 5, :fill)
	for pt in 1:2:length(pgon)
		pgon[pt] = between(pc, pgon[pt], 0.5)
	end
	poly(pgon, :stroke)
end

# ╔═╡ 81553c8a-ec57-4465-bc3c-e7aa84904279
@draw begin
	setopacity(0.5)
	eg(a) = egg(150, a)
	sethue("gold")
	eg(:fill)
	eg(:clip)
	@layer begin 
		for i in 360:-4:1
			sethue(Colors.HSV(i, 1.0, 0.8))
			rotate(π/30)
			ngon(O, i, 5, 0, :stroke)
		end
	end 
	clipreset()
	sethue("red")
	eg(:stroke)
end

# ╔═╡ Cell order:
# ╠═4db71ce9-4b21-4169-9f00-b763a36de8bc
# ╟─aff7ee1a-99aa-11eb-0901-bdf031382d27
# ╠═b0c23bbf-5c95-42fa-a6a8-40011eb45723
# ╠═18bc00c5-67af-429f-aa99-73f39c1056bf
# ╠═62dc9062-e933-47df-bb8d-d18e2007cc2d
# ╠═06b7532d-9a4c-4f37-9819-4877dc631a22
# ╠═9c19bc63-792a-4d20-a46b-7f8150a53d8e
# ╠═2e305d05-6125-45b5-884b-52596148cf77
# ╠═81553c8a-ec57-4465-bc3c-e7aa84904279
