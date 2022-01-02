# Packages used in Script
using Luxor
using Colors

# Auxiliary drawing functions
function make_drawing(width, height, img_path, bkg_color, origin_p)
    d = Drawing(width, height, img_path)
    background(bkg_color)
    origin(origin_p)
    return d
end

map2luxor(p) = Point(p.x, -p.y)

# Constants
## Canvas constants
width = 500
height = 500
path = "voronoi.png"
color = RGBA(.5, 0, .5)
op = Point(width / 2, height / 2)

## Point constants
p1 = (x = -125, y = 125)
p2 = (x = 125, y = 125)

# Setting up drawing
my_draw = make_drawing(width, height, path, color, op)

# Mathematical formulae for calculations
midpoint(x₁, y₁, x₂, y₂) = (x = (x₁ + x₂) / 2, y = (y₁ + y₂) / 2)
slope(x₁, y₁, x₂, y₂) = (y₂ - y₁) / (x₂ - x₁)
point_slope(x, x₁, y₁, m) = (x = x, y = m * (x - x₁) + y₁)
d(x1, y1, x2, y2, x, y) = (x - x1) * (y2 - y1) - (y - y1) * (x2 - x1)

#= 

Steps to create Voronoi diagram

1. Place points in an xy axis
2. Starting at one point, determine the midpoint between these points
3. Calculate the slope between these two points
4. Calculate the slope's reverse reciprocal
5. Find two points that lie on the line formed by the reverse reciprocal and midpoint
6. Calculate all points that lie in either half plane formed by the perpendicular bisector

=# 

sethue(RGBA(1, 1, 0))
circle(map2luxor(p1), 15; action = :fill)
circle(map2luxor(p2), 15; action = :fill)

sethue(RGBA(1, 1, 1))
line(map2luxor(p1), map2luxor(p2); action = :stroke)

mp = midpoint(p1.x, p1.y, p2.x, p2.y)

sethue(RGBA(0, 0, 0))
circle(map2luxor(mp), 7.5; action = :fill)

sp = slope(p1.x, p1.y, p2.x, p2.y)

rr = sp == 0 ? 0 : -1 / sp
sp1 = point_slope(width / 2, mp.x, mp.y, rr)
sp2 = point_slope(-width / 2, mp.x, mp.y, rr)

line(map2luxor(sp1), map2luxor(sp2); action = :stroke)

h1_plane = []
h2_plane = []
h3_plane = []
for x in (-width/2):(width/2), y in (-height/2):(height/2)
	if d(sp1.x, sp1.y, sp2.x, sp2.y, x, y) < 0 
		p = (x = x, y = y)
		push!(h1_plane, map2luxor(p))
	elseif d(sp1.x, sp1.y, sp2.x, sp2.y, x, y) > 0 
		p = (x = x, y = y)
		push!(h2_plane, map2luxor(p))
	else
		p = (x = x, y = y)
		push!(h3_plane, map2luxor(p))
	end
end

setcolor(1, 0, 0, 1)
for c in h1_plane
	circle(c, 1; action = :stroke)
end

setcolor(0, 0, 1, 1)
for c in h2_plane
	circle(c, 1; action = :stroke)
end

setcolor(1, 1, 1, 1)
for c in h3_plane
	circle(c, 1; action = :stroke)
end

setcolor(0, 0, 1, 1)
for plane in [h1_plane, h2_plane, h3_plane]
	if map2luxor(p1) in plane
		circle.(plane, 1; action = :stroke)
	end
end

finish()
