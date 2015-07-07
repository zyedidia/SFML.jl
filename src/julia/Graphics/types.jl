type RenderWindow
    ptr::Ptr{Void}
    _view::View

    function RenderWindow(ptr::Ptr{Void})
        w = new(ptr)
        w
        # finalizer(w, destroy)
        # w
    end
end
