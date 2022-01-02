using Colors
using Luxor

struct Pos
    x::Float64
    y::Float64
end

function jarvis_cross(point1::Pos, point2::Pos, point3::Pos)
    vec1 = Pos(point2.x - point1.x, point2.y - point1.y)
    vec2 = Pos(point3.x - point2.x, point3.y - point2.y)
    ret_cross = vec1.x*vec2.y - vec1.y*vec2.x
    return ret_cross*ret_cross
end

function jarvis_march(points::Vector{Pos})
    hull = Vector{Pos}()

    # sorting array based on leftmost point
    sort!(points, by = item -> item.x)
    push!(hull, points[1])

    i = 1
    curr_point = points[2]

    # Find cross product between points
    curr_product = jarvis_cross(Pos(0,0), hull[1], curr_point)
    while (curr_point != hull[1])
        for point in points
                product = 0.0
            if (i == 1)
                if (hull[i] != point)
                    product = jarvis_cross(Pos(0,0), hull[i], point)
                end
            else
                if (hull[i] != point && hull[i-1] != point)
                    product = jarvis_cross(hull[i-1], hull[i], point)
                end
            end
            if (product > curr_product)
                curr_point = point
                curr_product = product
            end
        end
        push!(hull, curr_point)
        curr_product = 0
        i += 1
    end

    return hull
end

function main(pts)
    hull = jarvis_march(pts)
end

# Auxiliary drawing functions
function make_drawing(width, height, img_path, bkg_color, origin_p)
    d = Drawing(width, height, img_path)
    background(bkg_color)
    origin(origin_p)
    return d
end

map2luxor(p) = Point(p.x, -p.y)
map2luxor(p) = Point(p...)

## Canvas constants
width = 500
height = 500
path = "arcane_march.png"
color = RGBA(0, 0, 0)
op = [width / 2, height / 2]

# Setting up drawing
my_draw = make_drawing(width, height, path, color, Point(op...))

# pts_list = [Pos(200, 15), Pos(100, 100), Pos(-20, -200), Pos(-130, 100)]
pts_list = [Pos(rand(-250:250), rand(-250:250)) for _ in 1:10]

hull = main(pts_list)
println(hull)
hull = [Point(p.x, -p.y) for p in hull]
println(hull)
pts_list = [Point(p.x, -p.y) for p in pts_list]

sethue(RGBA(1.0, 1.0, 0.0))
circle.(pts_list, 15; action = :fill)

sethue(RGBA(1.0, 1.0, 1.0))
poly(hull, action = :stroke; close = true)

finish()
