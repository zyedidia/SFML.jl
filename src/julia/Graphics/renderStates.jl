mutable struct RenderStates
    ptr::Ptr{Nothing}

    function RenderStates(ptr::Ptr{Nothing})
        self = new(ptr)
        finalizer(self, destroy)
        self
    end
end

function RenderStates(blendmode::BlendMode=blend_alpha, shader::Shader=Shader(), texture::Texture=Texture())
    RenderStates(ccall((:sjRenderStates_create, "libjuliasfml"), Ptr{Nothing}, (BlendMode, Ptr{Nothing}, Ptr{Nothing}), blendmode, shader.ptr, texture.ptr))
end

RenderStates(s::Shader) = RenderStates(blend_alpha, s, Texture())
RenderStates(t::Texture) = RenderStates(blend_alpha, Shader(), t)


function set_texture(states::RenderStates, texture::Texture)
    ccall((:sjRenderStates_setTexture, "libjuliasfml"), Ptr{Nothing}, (Ptr{Nothing}, Ptr{Nothing}), states.ptr, texture.ptr)
end

function destroy(states::RenderStates)
    ccall((:sjRenderStates_destroy, "libjuliasfml"), Nothing, (Ptr{Nothing},), states.ptr)
end
