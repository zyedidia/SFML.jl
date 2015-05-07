type RenderWindow
	ptr::Ptr{Void}

	function RenderWindow(ptr::Ptr{Void})
		w = new(ptr)
		finalizer(w, destroy)
		w
	end
end
