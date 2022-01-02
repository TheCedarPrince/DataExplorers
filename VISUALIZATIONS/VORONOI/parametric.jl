# Packages used in Script
using Colors
using Interpolations
using LazySets
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
path = "voronoi.png"
color = RGBA(0.5, 0, 0.5)
op = Point(width / 2, height / 2)

# Setting up drawing
my_draw = make_drawing(width, height, path, color, op)

# Mathematical formulae for calculations
midpoint(x₁, y₁, x₂, y₂) = (x = (x₁ + x₂) / 2, y = (y₁ + y₂) / 2)
parametric_point(t, x, y) = x + y * t
d(x1, y1, x2, y2, x, y) = (x - x1) * (y2 - y1) - (y - y1) * (x2 - x1)

## Point constants
p1 = [125; 125]
p2 = [170; 10]
p3 = [-200; 0]
p4 = [-30; -140]
p5 = [0; -5]

sethue(RGBA(1, 1, 0))
circle(map2luxor(p1), 15; action = :fill)
circle(map2luxor(p2), 15; action = :fill)
circle(map2luxor(p3), 15; action = :fill)
circle(map2luxor(p4), 15; action = :fill)
circle(map2luxor(p5), 15; action = :fill)

pts_list = [p1, p2, p3, p4, p5]
border_seeds = convex_hull(pts_list)
inner_seeds = setdiff(pts_list, border_seeds)

inner_hulls = []

for pt in inner_seeds
    edges = []
    sub_pts_list = [x for x in pts_list if x != pt]
    for s in sub_pts_list
        p_vec = pt - s
        mp = midpoint(s[1], s[2], pt[1], pt[2])

        x = 1
        y = 1
        if (-1 * p_vec[1] * x) / p_vec[2] |> isinf
            x = (p_vec[2] * y) / (-1 * p_vec[1])
        else
            y = (-1 * p_vec[1] * x) / p_vec[2]
        end

        p = [parametric_point(i, [mp.x; mp.y], [x; y]) for i = -10:10]
        x = [i[1] for i in p]
        y = [i[2] for i in p]
        ext =
            interpolate((x,), y, Gridded(Linear())) |>
            foo -> extrapolate(foo, Interpolations.Line())

        sethue(RGBA(1, 1, 1))
        push!(edges, [map2luxor([-250, ext(-250)]), map2luxor([250, ext(250)])])
        # Luxor.line(
        # map2luxor([-250, ext(-250)]),
        # map2luxor([250, ext(250)]);
        # action = :stroke,
        # )
    end

    vtx = []
    for e1 in edges
        for e2 in edges
            if e1 != e2
                push!(vtx, (intersectionlines(e1[1], e1[2], e2[1], e2[2]))[2])
            end
        end
    end

    # TODO: Add line check here

    vtx = vtx |> unique
    distances = Luxor.distance.(vtx, Point(pt...))
    v_vtx = vtx[sortperm(distances)][1:4] |> x -> convert(Vector{Point}, x)
    hull = [[p.x, p.y] for p in v_vtx] |> convex_hull
    lux_hull = hull |> x -> [Point(p[1], p[2]) for p in x]

    sethue(RGBA(1.0, 0.7529411764705882, 0.796078431372549))
    poly(lux_hull; close = true, action = :fill)

    sethue(RGBA(0, 0, 0))
    poly(lux_hull; close = true, action = :stroke)

    push!(inner_hulls, hull)

    # TODO: Determine how to get canvas edge points

end

for pt in border_seeds
    edges = [
        [map2luxor([-250, -250]), map2luxor([250, -250])],
        [map2luxor([-250, 250]), map2luxor([250, 250])],
        [map2luxor([-250, -250]), map2luxor([-250, 250])],
        [map2luxor([250, -250]), map2luxor([250, 250])],
    ]

    sethue(RGBA(1, 1, 1))
    # Top edge
    Luxor.line(map2luxor([-250, -250]), map2luxor([250, -250]); action = :stroke)

    # Bottom edge
    Luxor.line(map2luxor([-250, 250]), map2luxor([250, 250]); action = :stroke)

    # Left edge
    Luxor.line(map2luxor([-250, -250]), map2luxor([-250, 250]); action = :stroke)

    # Right edge
    Luxor.line(map2luxor([250, -250]), map2luxor([250, 250]); action = :stroke)

    sub_pts_list = [x for x in pts_list if x != pt]
    for s in sub_pts_list
        p_vec = pt - s
        mp = midpoint(s[1], s[2], pt[1], pt[2])

        x = 1
        y = 1
        if (-1 * p_vec[1] * x) / p_vec[2] |> isinf
            x = (p_vec[2] * y) / (-1 * p_vec[1])
        else
            y = (-1 * p_vec[1] * x) / p_vec[2]
        end

        p = [parametric_point(i, [mp.x; mp.y], [x; y]) for i = -10:10]
        x = [i[1] for i in p]
        y = [i[2] for i in p]
        ext =
            interpolate((x,), y, Gridded(Linear())) |>
            foo -> extrapolate(foo, Interpolations.Line())

        sethue(RGBA(1, 1, 1))
        push!(edges, [map2luxor([-250, ext(-250)]), map2luxor([250, ext(250)])])
        Luxor.line(
            map2luxor([-250, ext(-250)]),
            map2luxor([250, ext(250)]);
            action = :stroke,
        )
    end

    vtx = []
    inner_vtx = []
    for e1 in edges
        for e2 in edges
            if e1 != e2
                v = (intersectionlines(e1[1], e1[2], e2[1], e2[2]))[2]
                push!(vtx, v)
                if v in inner_hulls[1] .|> map2luxor
                    push!(inner_vtx, v)
                end
            end
        end
    end

    # TODO: Add line check here

    sethue(RGBA(1.0, 0.7529411764705882, 0.796078431372549))

    vtx = vtx |> unique |> x -> [[p.x, p.y] for p in x]
    v_vtx = []
    for p in vtx
        if !(element(Singleton(p)) ∈ VPolygon(inner_hulls[1]))
            push!(v_vtx, p)
        end
    end

    v_vtx = vcat(v_vtx, inner_vtx |> unique)
    filt_v_vtx = []
    for p in v_vtx
    println(p)
	if (-width <= p[1] <= width) && (-height <= p[2] <= height)
		push!(filt_v_vtx, p)
	end
    end

    distances = filt_v_vtx .|> x -> Point(x...) |> x -> Luxor.distance.(x, Point(pt...))
    filt_v_vtx = filt_v_vtx .|> x -> Point(x...)
    clipboard(filt_v_vtx)
    filt_v_vtx = filt_v_vtx[sortperm(distances)][1:5]
    hull = [[p.x, p.y] for p in filt_v_vtx] |> convex_hull |> x -> [Point(p[1], p[2]) for p in x]

    sethue(RGBA(1.0, 0.7529411764705882, 0.796078431372549))
    poly(hull; close = true, action = :fill)

    sethue(RGBA(0, 0, 0))
    poly(hull; close = true, action = :stroke)

end

finish()
