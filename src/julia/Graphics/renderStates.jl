type RenderStates
    ptr::Ptr{Void}

    function RenderStates(ptr::Ptr{Void})
        self = new(ptr)
        finalizer(self, destroy)
        self
    end
end

function RenderStates(blendmode::BlendMode=blend_alpha, shader::Shader=Shader(), texture::Texture=Texture())
    RenderStates(ccall((:sjRenderStates_create, "libjuliasfml"), Ptr{Void}, (BlendMode, Ptr{Void}, Ptr{Void}), blendmode, shader.ptr, texture.ptr))
end

RenderStates(s::Shader) = RenderStates(blend_alpha, s, Texture())
RenderStates(t::Texture) = RenderStates(blend_alpha, Shader(), t)


function set_texture(states::RenderStates, texture::Texture)
    ccall((:sjRenderStates_setTexture, "libjuliasfml"), Ptr{Void}, (Ptr{Void}, Ptr{Void}), states.ptr, texture.ptr)
end

function destroy(states::RenderStates)
    ccall((:sjRenderStates_destroy, "libjuliasfml"), Void, (Ptr{Void},), states.ptr)
end
