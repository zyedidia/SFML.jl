type Shader
	ptr::Ptr{Void}

	function Shader(ptr::Ptr{Void})
		s = new(ptr)
		finalizer(s, destroy)
		s
	end
end

function Shader(vertex_shader::String, frag_shader::String)
	vert = isempty(vertex_shader) ? C_NULL : vertex_shader
	frag = isempty(frag_shader) ? C_NULL : frag_shader
	Shader(ccall(dlsym(libcsfml_graphics, :sfShader_create), Ptr{Void}, (Ptr{Cchar}, Ptr{Cchar},), pointer(vert), pointer(frag)))
end

function Shader(shader_filename::String, shader_type::String = shader_filename[search(shader_filename, ".")+1:end])
	if shader_type == "vert"
		Shader(shader_filename, "")
	elseif shader_type == "frag"
		Shader("", shader_filename)
	else
		println("Invalid shader type $shader_type")
	end
end

function destroy(shader::Shader)
	ccall(dlsym(libcsfml_graphics, :sfShader_destroy), Void, (Ptr{Void},), shader.ptr)
end

function set_parameter(shader::Shader, name::String, x::Real)
	ccall(dlsym(libcsfml_graphics, :sfShader_setFloatParameter), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat,), shader.ptr, pointer(name), x)
end

function set_parameter(shader::Shader, name::String, x::Real, y::Real)
	ccall(dlsym(libcsfml_graphics, :sfShader_setFloat2Parameter), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat, Cfloat,), shader.ptr, pointer(name), x, y)
end

function set_parameter(shader::Shader, name::String, x::Real, y::Real, z::Real)
	ccall(dlsym(libcsfml_graphics, :sfShader_setFloat3Parameter), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat, Cfloat, Cfloat,), shaper.ptr, pointer(name), x, y, z)
end

function set_parameter(shader::Shader, name::String, x::Real, y::Real, z::Real, w::Real)
	ccall(dlsym(libcsfml_graphics, :sfShader_setFloat4Parameter), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat, Cfloat, Cfloat, Cfloat), shaper.ptr, pointer(name), x, y, z, w)
end

function set_parameter(shader::Shader, name::String, vector::Vector2f)
	ccall(dlsym(libcsfml_graphics, :sfShader_setVector2Parameter), Void, (Ptr{Void}, Ptr{Cchar}, Vector2f,), shader.ptr, pointer(name), vector)
end

function set_parameter(shader::Shader, name::String, color::Color)
	ccall(dlsym(libcsfml_graphics, :sfShader_setColorParameter), Void, (Ptr{Void}, Ptr{Cchar}, Color), shader.ptr, pointer(name), color)
end

function set_parameter(shader::Shader, name::String, texture::Texture)
	ccall(dlsym(libcsfml_graphics, :sfShader_setTextureParameter), Void, (Ptr{Void}, Ptr{Cchar}, Ptr{Void},), shader.ptr, pointer(name), texture.ptr)
end

function set_parameter(shader::Shader, name::String)
	ccall(dlsym(libcsfml_graphics, :sfShader_setCurrentTextureParameter), Void, (Ptr{Void}, Ptr{Cchar},), shader.ptr, pointer(name))
end

function shader_is_available()
	Bool(ccall(dlsym(libcsfml_graphics, :sfShader_isAvailable), Int32, ()))
end

export Shader, destroy, set_parameter, shader_is_available
