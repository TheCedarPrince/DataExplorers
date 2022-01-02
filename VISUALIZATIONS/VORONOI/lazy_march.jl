using Colors
using LazySets
using Luxor

# Auxiliary drawing functions
function make_drawing(width, height, img_path, bkg_color, origin_p)
    d = Drawing(width, height, img_path)
    background(bkg_color)
    origin(origin_p)
    return d
end

## Canvas constants
width = 500
height = 500
path = "jarvis_march.png"
color = RGBA(0, 0, 0)
op = [width / 2, height / 2]

# Setting up drawing
my_draw = make_drawing(width, height, path, color, Point(op...))

sethue(RGBA(1.0, 0.9411764705882353, 0.0))
pts_list = [[rand(-250:250), rand(-250:250)] for _ in 1:10]
hull = convex_hull(pts_list)

map2luxor.(pts_list) .|> cp -> circle(cp, 15; action = :fill)
hull = map2luxor.(hull) 

sethue(RGBA(1.0, 1.0, 1.0))
poly(hull, action = :stroke; close = true)

finish()
