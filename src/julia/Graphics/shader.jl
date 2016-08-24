type Shader
    ptr::Ptr{Void}

    function Shader(ptr::Ptr{Void})
        s = new(ptr)
        # finalizer(s, destroy)
        # s
    end
end

function Shader(vertex_shader::AbstractString, frag_shader::AbstractString)
    vert = isempty(vertex_shader) ? C_NULL : vertex_shader
    frag = isempty(frag_shader) ? C_NULL : frag_shader
    Shader(ccall((:sfShader_createFromFile, libcsfml_graphics), Ptr{Void}, (Ptr{Cchar}, Ptr{Cchar},), vert, frag))
end
Shader() = Shader("", "")

function ShaderFromMemory(vertex_shader::AbstractString, frag_shader::AbstractString)
    vert = isempty(vertex_shader) ? C_NULL : vertex_shader
    frag = isempty(frag_shader) ? C_NULL : frag_shader
    Shader(ccall((:sfShader_createFromMemory, libcsfml_graphics), Ptr{Void}, (Ptr{Cchar}, Ptr{Cchar},), vert, frag))
end

function Shader(shader::AbstractString)
    shadername = basename(shader)
    if shadername[search(shadername, ".")+1] == "v"
        # This shader is a vertex shader
        Shader(shader, "")
    elseif shadername[search(shadername, ".") + 1] == "f"
        # This shader is a fragment shader
        Shader("", shader)
    else
        println("$shadername is not a valid shader file")
    end
end

function destroy(shader::Shader)
    ccall((:sfShader_destroy, libcsfml_graphics), Void, (Ptr{Void},), shader.ptr)
end

function set_parameter(shader::Shader, name::AbstractString, x::Real)
    ccall((:sfShader_setFloatParameter, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat,), shader.ptr, name, x)
end

function set_parameter(shader::Shader, name::AbstractString, x::Real, y::Real)
    ccall((:sfShader_setFloat2Parameter, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat, Cfloat,), shader.ptr, name, x, y)
end

function set_parameter(shader::Shader, name::AbstractString, x::Real, y::Real, z::Real)
    ccall((:sfShader_setFloat3Parameter, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat, Cfloat, Cfloat,), shader.ptr, name, x, y, z)
end

function set_parameter(shader::Shader, name::AbstractString, x::Real, y::Real, z::Real, w::Real)
    ccall((:sfShader_setFloat4Parameter, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat, Cfloat, Cfloat, Cfloat), shader.ptr, name, x, y, z, w)
end

function set_parameter(shader::Shader, name::AbstractString, vector::Vector2f)
    ccall((:sfShader_setVector2Parameter, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Cchar}, Vector2f,), shader.ptr, name, vector)
end

function set_parameter(shader::Shader, name::AbstractString, vector::Vector3f)
    ccall((:sfShader_setVector3Parameter, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Cchar}, Vector3f), shader.ptr, name, vector)
end

function set_parameter(shader::Shader, name::AbstractString, color::Color)
    ccall((:sfShader_setColorParameter, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Cchar}, Color), shader.ptr, name, color)
end

function set_parameter(shader::Shader, name::AbstractString, texture::Texture)
    ccall((:sfShader_setTextureParameter, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Cchar}, Ptr{Void},), shader.ptr, name, texture.ptr)
end

function set_parameter(shader::Shader, name::AbstractString)
    ccall((:sfShader_setCurrentTextureParameter, libcsfml_graphics), Void, (Ptr{Void}, Ptr{Cchar},), shader.ptr, name)
end

function bind(shader::Shader)
    ccall((:sfShader_bind, libcsfml_graphics), Void, (Ptr{Void},), shader.ptr)
end

function unbind()
    ccall((:sfShader_bind, libcsfml_graphics), Void, (Ptr{Void},), C_NULL)
end

function shader_is_available()
    ccall((:sfShader_isAvailable, libcsfml_graphics), Bool, ())
end
