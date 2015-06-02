type RenderStates
	# blend_mode::BlendMode
	# transform::Transform
	# texture::Ptr{Void}
	# shader::Ptr{Void}
	ptr::Ptr{Void}
end

function RenderStates(shader::Shader)
	# blendAlpha = unsafe_load(cglobal(dlsym(libcsfml_graphics, :sfBlendAlpha), BlendMode))
	# identity = unsafe_load(cglobal(dlsym(libcsfml_graphics, :sfTransform_Identity), Transform))
	# RenderStates(blendAlpha, identity, C_NULL, shader.ptr)
	RenderStates(ccall(dlsym(libjuliasfml, :sjShader_setShader), Ptr{Void}, (Ptr{Void},), shader.ptr))
end

export RenderStates
