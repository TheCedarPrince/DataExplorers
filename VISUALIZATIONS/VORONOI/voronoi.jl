using Luxor
using OffsetArrays

function make_drawing(width, height, img_path, bkg_color, origin_p)
    d = Drawing(width, height, img_path)
    background(bkg_color)
    origin(origin_p)
    return d
end

width = 500
height = 500
path = "voronoi.png"
color = "black"

my_draw = make_drawing(width, height, path, color, O)

slope(x₁, y₁, x₂, y₂) = (y₂ - y₁) / (x₂ - x₁)
slope(P1, P2) = (P2.y - P1.y) / (P2.x - P1.x)
midpoint(x₁, y₁, x₂, y₂) = ((x₁ + x₂) / 2, (y₁ + y₂) / 2)
midpoint(P1, P2) = ((P1.x + P2.x) / 2, (P2.y + P2.y) / 2)
point_slope(x, x₁, y₁, m) = (x, m * (x - x₁) + y₁)

mat = zeros(width, height)

p1 = (x = 125, y = 125)
p2 = (x = 375, y = 375)

sp = slope(p1, p2)
mp = midpoint(p1, p2)

d(x1, y1, x2, y2, x, y) = (x - x1) * (y2 - y1) - (y - y1) * (x2 - x1)

h1_plane = []
h2_plane = []
h3_plane = []

for x in 1:500, y in 1:500
	if d(500, 0, mp[1], mp[2], x, y) < 0 
		push!(h1_plane, Point(x, y))
	elseif d(500, 0, mp[1], mp[2], x, y) > 0 
		push!(h2_plane, Point(x, y))
	else
		push!(h3_plane, Point(x, y))
	end
end


# for p in vals
	# mat[Int(p.x), Int(p.y)] = 1
# end

# function half_plane(p1, p2, width, height)

    # mp = midpoint(p1.x, p1.y, p2.x, p2.y) |> Point
    # sp = slope(p1.x, p1.y, p2.x, p2.y)
    # first_point = point_slope(-250, mp.x, mp.y, sp == 0 ? 0 : -1 / sp) |> Point
    # second_point = point_slope(250, mp.x, mp.y, sp == 0 ? 0 : -1 / sp) |> Point

    # half_1 = [first_point, second_point, Point(width / 2, height / 2)]
    # half_2 = [first_point, second_point, Point(-width / 2, height / 2)]

    # return half_1, half_2
# end

setcolor(1, 0, 0, 1)
for c in h1_plane
	circle(c, 1; action = :stroke)
end

setcolor(0, 0, 1, 1)
for c in h2_plane
	circle(c, 1; action = :stroke)
end

setcolor(1, 1, 0, 1)
for c in h3_plane
	circle(c, 1; action = :stroke)
end

setcolor(1, 0, 0, 1)
circle(p1.x, p1.y, 15, action = :fill)

setcolor(0, 0, 1, 1)
circle(p2.x, p2.y, 15, action = :fill)

finish()
