mutable struct RenderWindow
    ptr::Ptr{Nothing}
    _view::View

    function RenderWindow(ptr::Ptr{Nothing})
        w = new(ptr)
        w
        # finalizer(w, destroy)
        # w
    end
end
