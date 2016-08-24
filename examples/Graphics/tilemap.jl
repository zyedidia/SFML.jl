using SFML

"""
Interface to image file containing tiles.
"""
type TileSet
    texture::Texture
    size::Tuple{Int, Int}  # number of tiles in each direction
    tilesize::Vector2i # in pixel
    function TileSet(texture::Texture, siz::Tuple{Int, Int}, tilesize::Vector2i)
        texture_size = texture |> get_size |> Vector2i
        calc_size = Vector2i(siz...) * tilesize
        @assert map(<=, calc_size, texture_size) |> all
        new(texture, siz, tilesize)
    end
end

tileset(t::TileSet) = t
tilesize(ts::TileSet) = ts.tilesize
tilesize(t) = t |> tileset |> tilesize
Base.size(ts::TileSet) = ts.size
Base.size(ts::TileSet, i) = size(ts)[i]
tilewidth(ts) = tilesize(ts)[1]
tileheight(ts) = tilesize(ts)[2]

function TileSet(texture::Texture, siz, tilesiz)
    TileSet(texture, tuple(siz...), Vector2i(tilesiz...))
end

function TileSet(filename::String, size_, tilesize)
    TileSet(Texture(filename), size_, tilesize)
end

immutable Tile
    corners::NTuple{4, Vector2f} # pixel coords of corners of tile in TileSet
end

corners(t::Tile) = t.corners

_colors4() = (SFML.white,SFML.white,SFML.white,SFML.white)

function Base.convert(::Type{VertexArray}, t::Tile)
    vertices = map(Vertex, corners(t), _colors4(), corners(t))
    va = VertexArray()
    set_primitive_type(va, SFML.quads)
    for v in vertices
        append(va, v)
    end
    va
end

type TileMap
    tilemat::Matrix{Tile}
    globalbounds::FloatRect
    ts::TileSet
end

function TileMap(tmat::Matrix{Tile}, ts::TileSet)
    width, height = Vector2i(size(tmat)...) * tilesize(ts)
    r = FloatRect(0,0,width, height)
    return TileMap(tmat, r, ts)
end


tilematrix(tm::TileMap) = tm.tilemat
Base.size(tm::TileMap, dims...) = size(tm |> tilematrix, dims...)

function subrect(tm::TileMap,i,j)
    r = tm.globalbounds
    n,m = size(tm)
    width = r.width/n
    height = r.height/m
    left = r.left + (i-1) * width
    top = r.top + (j-1) * height
    FloatRect(left, top, width, height)
end

function Base.convert(::Type{VertexArray}, tm::TileMap)
    va = VertexArray()
    set_primitive_type(va, SFML.quads)
    for i in 1:size(tm,1), j in 1:size(tm,2)
        t = tilematrix(tm)[i,j]
        r = subrect(tm, i, j)
        pushtile!(va, r, t)
    end
    va
end

function pushtile!(va::VertexArray, r::FloatRect, t::Tile)
    # colors = (SFML.white, SFML.white, SFML.white, SFML.white)
    verts = map(Vertex, corners(r), _colors4(), corners(t))
    for v in verts
        append(va, v)
    end
    va
end

function Base.getindex(ts::TileSet, i::Int, j::Int)
    c = setcoords2tilerect(ts, Vector2i(i,j)) |> corners |> Tile
end

function corners(r::Union{FloatRect, IntRect})
    x_lower = r.left
    x_upper = x_lower + r.width
    y_lower = r.top
    y_upper = r.top + r.height
    return (
        Vector2(x_lower, y_upper),
        Vector2(x_lower, y_lower),
        Vector2(x_upper, y_lower),
        Vector2(x_upper, y_upper)
    )
end

function setcoords2tilerect(ts::TileSet, setcoords::Vector2i)
    left, top = (ts |> tilesize) * (setcoords - Vector2i(1,1))
    width, height = (ts |> tilesize)
    return FloatRect(left, top, width, height)
end

ts = TileSet("tiles.png", (7, 5), (17,17))
water = ts[1,1]
wall = ts[2,1]
lava = ts[3,1]
tube = ts[4,5]

m = [water water water;
    lava   tube  tube ;
    lava   lava  lava ;
    wall   wall  wall ;
]

vertex_array = TileMap(m, ts) |> VertexArray
states = RenderStates(ts.texture)


window=RenderWindow("quick window", 800, 600)
event = Event()
while isopen(window)
    while pollevent(window, event)
        (get_type(event) == EventType.CLOSED) && close(window)
    end
    clear(window, SFML.black)
    draw(window, vertex_array, states)
    display(window)
end
