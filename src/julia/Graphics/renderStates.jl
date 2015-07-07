type RenderStates
    ptr::Ptr{Void}

    function RenderStates(ptr::Ptr{Void})
        self = new(ptr)
        finalizer(self, destroy)
        self
    end
end

function RenderStates(shader::Shader)
    RenderStates(ccall((:sjRenderStates_create, "libjuliasfml"), Ptr{Void}, (BlendMode, Ptr{Void},), blend_alpha, shader.ptr))
end
function RenderStates(blendmode::BlendMode, shader::Shader)
    RenderStates(ccall((:sjRenderStates_create, "libjuliasfml"), Ptr{Void}, (BlendMode, Ptr{Void},), blendmode, shader.ptr))
end

function destroy(states::RenderStates)
    ccall((:sjRenderStates_destroy, "libjuliasfml"), Void, (Ptr{Void},), states.ptr)
end
