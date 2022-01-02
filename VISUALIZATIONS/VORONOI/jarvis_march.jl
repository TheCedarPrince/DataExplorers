using Colors
using LinearAlgebra
using Luxor

# Auxiliary drawing functions
function make_drawing(width, height, img_path, bkg_color, origin_p)
    d = Drawing(width, height, img_path)
    background(bkg_color)
    origin(origin_p)
    return d
end

map2luxor(p) = Point(p.x, -p.y)
map2luxor(p) = Point(p...)

# Constants

## Canvas constants
width = 500
height = 500
path = "jarvis_march.png"
color = RGBA(0, 0, 0)
op = [width / 2, height / 2]

# Setting up drawing
my_draw = make_drawing(width, height, path, color, Point(op...))

# Points

p1 = [125, 125]
p2 = [170, -200]
p3 = [-200, 0] #leftmost point
p4 = [-30, -140]
p5 = [0, -5]
p6 = [200, 150]
p7 = [100, 230]
p8 = [220, 0]
p9 = [-100, 80]
p10 = [-90, -200]

sethue(RGBA(1.0, 0.9411764705882353, 0.0))
# pts_list = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10] .|> x -> Point(x...)
pts_list = [Point(rand(-250:250), rand(-250:250)) for _ in 1:10]
map2luxor.(pts_list) .|> cp -> circle(cp, 15; action = :fill)

sethue(RGBA(1.0, 0.0, 0.0))
leftmost_pt = sort!(pts_list, by = pt -> pt.x) |> x -> x[1]
map2luxor(leftmost_pt) |> x -> circle(x, 15; action = :fill)

sethue(RGBA(0.0, 0.0, 1))
circle(Point(0, 0), 15; action = :fill)

hull = [leftmost_pt]
let
    curr_point = pts_list[2]
    curr_product = crossproduct(leftmost_pt, curr_point) |> abs
    i = 1
    while curr_point != leftmost_pt
        for pt in pts_list
            product = 0
            if i == 1
                if hull[i] != pt
                    product = crossproduct(hull[i], pt)
                end
            else
                if hull[i] != pt && hull[i - 1] != pt
                    product = crossproduct(hull[i - 1], pt)
                end
            end
            if (product > curr_product)
                curr_point = pt
                curr_product = product
            end
        end
        push!(hull, curr_point)
        curr_product = 0
        i += 1
    end

end

sethue(RGBA(1.0, 1.0, 1.0))
poly(hull, action = :stroke; close = true)

finish()
