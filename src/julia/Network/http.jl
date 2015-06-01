@enum(HttpMethod,
HttpGet,
HttpPost,
HttpHead,
HttpPut,
HttpDelete)

type HttpRequest
	ptr::Ptr{Void}

	function HttpRequest(ptr::Ptr{Void})
		self = new(ptr)
		finalizer(self, destroy)
		self
	end
end

function HttpRequest()
	HttpRequest(ccall(dlsym(libcsfml_network, :sfHttpRequest_create), Ptr{Void}, ()))
end

function destroy(request::HttpRequest)
	ccall(dlsym(libcsfml_network, :sfHttpRequest_destroy), Void, (Ptr{Void},), request.ptr)
end

function set_field(request::HttpRequest, field::String, value::String)
	ccall(dlsym(libcsfml_network, :sfHttpRequest_setField), Void, (Ptr{Void}, Ptr{Cchar}, Ptr{Cchar},), request.ptr, pointer(field), pointer(value))
end

function set_method(request::HttpRequest, method::HttpMethod)
	ccall(dlsym(libcsfml_network, :sfHttpRequest_setMethod), Void, (Ptr{Void}, Int32,), request.ptr, Int32(method))
end

function set_uri(request::HttpRequest, uri::String)
	ccall(dlsym(libcsfml_network, :sfHttpRequest_setUri), Void, (Ptr{Void}, Ptr{Cchar},), request.ptr, pointer(uri))
end

function set_http_version(request::HttpRequest, major::Integer, minor::Integer)
	ccall(dlsym(libcsfml_network, :sfHttpRequest_setHttpVersion), Void, (Ptr{Void}, Int32, Int32,), request.ptr, major, minor)
end

function set_body(request::HttpRequest, body::String)
	ccall(dlsym(libcsfml_network, :sfHttpRequest_setBody), Void, (Ptr{Void}, Ptr{Cchar},), request.ptr, pointer(body))
end

type HttpResponse
	ptr::Ptr{Void}

	function HttpResponse(ptr::Ptr{Void})
		self = new(ptr)
		finalizer(self, destroy)
		self
	end
end

function destroy(response::HttpResponse)
	ccall(dlsym(libcsfml_network, :sfHttpResponse_destroy), Void, (Ptr{Void},), response.ptr)
end

function get_field(response::HttpResponse, field::String)
	bytestring(ccall(dlsym(libcsfml_network, :sfHttpResponse_getField), Ptr{Cchar}, (Ptr{Void}, Ptr{Cchar},), response.ptr, pointer(field)))
end

function get_major_version(response::HttpResponse)
	ccall(dlsym(libcsfml_network, :sfHttpResponse_getMajorVersion), Uint32, (Ptr{Void},), response.ptr)
end

function get_minor_version(response::HttpResponse)
	ccall(dlsym(libcsfml_network, :sfHttpResponse_getMinorVersion), Uint32, (Ptr{Void},), response.ptr)
end

function get_body(response::HttpResponse)
	bytestring(ccall(dlsym(libcsfml_network, :sfHttpResponse_getBody), Ptr{Cchar}, (Ptr{Void},), response.ptr))
end

type Http
	ptr::Ptr{Void}

	function Http(ptr::Ptr{Void})
		self = new(ptr)
		finalizer(self, destroy)
		self
	end
end

function Http()
	Http(ccall(dlsym(libcsfml_network, :sfHttp_create), Ptr{Void}, ()))
end

function destroy(http::Http)
	ccall(dlsym(libcsfml_network, :sfHttp_destroy), Void, (Ptr{Void},), http.ptr)
end

function set_host(http::Http, host::String, port::Integer)
	ccall(dlsym(libcsfml_network, :sfHttp_setHost), Void, (Ptr{Void}, Ptr{Cchar}, Uint16), http.ptr, pointer(host), port)
end

function send_request(http::Http, request::HttpRequest, timeout::Time)
	HttpResponse(ccall(dlsym(libcsfml_network, :sfHttp_sendRequest), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Time), http.ptr, request.ptr, timeout))
end

export HttpResponse, HttpResponse, HttpMethod, Http, set_host, send_request, set_body, set_http_version, set_uri, get_field, get_body,
get_major_version, get_minor_version, set_field, set_method
