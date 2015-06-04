type RenderStates
	# blend_mode::BlendMode
	# transform::Transform
	# texture::Ptr{Void}
	# shader::Ptr{Void}
	ptr::Ptr{Void}
end

function RenderStates(shader::Shader)
	blendAlpha = unsafe_load(cglobal(dlsym(libcsfml_graphics, :sfBlendAlpha), BlendMode))
	RenderStates(ccall((:sjShader_setShader, "libjuliasfml"), Ptr{Void}, (BlendMode, Ptr{Void},), blendAlpha, shader.ptr))
end
function RenderStates(blendmode::BlendMode, shader::Shader)
	RenderStates(ccall((:sjShader_setShader, "libjuliasfml"), Ptr{Void}, (BlendMode, Ptr{Void},), blendmode, shader.ptr))
end

export RenderStates
