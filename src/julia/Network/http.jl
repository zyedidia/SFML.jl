@enum(HttpMethod,
HttpGet,
HttpPost,
HttpHead,
HttpPut,
HttpDelete)

@enum(HttpStatus,
    # 2xx: success
    HttpOk             = 200, # Most common code returned when operation was successful
    HttpCreated        = 201, # The resource has successfully been created
    HttpAccepted       = 202, # The request has been accepted, but will be processed later by the server
    HttpNoContent      = 204, # Sent when the server didn't send any data in return
    HttpResetContent   = 205, # The server informs the client that it should clear the view (form) that caused the request to be sent
    HttpPartialContent = 206, # The server has sent a part of the resource, as a response to a partial GET request

    # 3xx: redirection
    HttpMultipleChoices  = 300, # The requested page can be accessed from several locations
    HttpMovedPermanently = 301, # The requested page has permanently moved to a new location
    HttpMovedTemporarily = 302, # The requested page has temporarily moved to a new location
    HttpNotModified      = 304, # For conditional requests, means the requested page hasn't changed and doesn't need to be refreshed

    # 4xx: client error
    HttpBadRequest          = 400, # The server couldn't understand the request (syntax error)
    HttpUnauthorized        = 401, # The requested page needs an authentication to be accessed
    HttpForbidden           = 403, # The requested page cannot be accessed at all, even with authentication
    HttpNotFound            = 404, # The requested page doesn't exist
    HttpRangeNotSatisfiable = 407, # The server can't satisfy the partial GET request (with a "Range" header field)

    # 5xx: server error
    HttpInternalServerError = 500, # The server encountered an unexpected error
    HttpNotImplemented      = 501, # The server doesn't implement a requested feature
    HttpBadGateway          = 502, # The gateway server has received an error from the source server
    HttpServiceNotAvailable = 503, # The server is temporarily unavailable (overloaded, in maintenance, ...)
    HttpGatewayTimeout      = 504, # The gateway server couldn't receive a response from the source server
    HttpVersionNotSupported = 505, # The server doesn't support the requested HTTP version

    # 10xx: SFML custom codes
    HttpInvalidResponse  = 1000, # Response is not a valid HTTP one
    HttpConnectionFailed = 1001  # Connection with server failed
)

type HttpRequest
    ptr::Ptr{Void}

    function HttpRequest(ptr::Ptr{Void})
        self = new(ptr)
        finalizer(self, destroy)
        self
    end
end

function HttpRequest()
    HttpRequest(ccall((:sfHttpRequest_create, libcsfml_network), Ptr{Void}, ()))
end

function destroy(request::HttpRequest)
    ccall((:sfHttpRequest_destroy, libcsfml_network), Void, (Ptr{Void},), request.ptr)
end

function set_field(request::HttpRequest, field::AbstractString, value::AbstractString)
    ccall((:sfHttpRequest_setField, libcsfml_network), Void, (Ptr{Void}, Ptr{Cchar}, Ptr{Cchar},), request.ptr, field, value)
end

function set_method(request::HttpRequest, method::HttpMethod)
    ccall((:sfHttpRequest_setMethod, libcsfml_network), Void, (Ptr{Void}, Int32,), request.ptr, Int32(method))
end

function set_uri(request::HttpRequest, uri::AbstractString)
    ccall((:sfHttpRequest_setUri, libcsfml_network), Void, (Ptr{Void}, Ptr{Cchar},), request.ptr, uri)
end

function set_http_version(request::HttpRequest, major::Integer, minor::Integer)
    ccall((:sfHttpRequest_setHttpVersion, libcsfml_network), Void, (Ptr{Void}, Int32, Int32,), request.ptr, major, minor)
end

function set_body(request::HttpRequest, body::AbstractString)
    ccall((:sfHttpRequest_setBody, libcsfml_network), Void, (Ptr{Void}, Ptr{Cchar},), request.ptr, body)
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
    ccall((:sfHttpResponse_destroy, libcsfml_network), Void, (Ptr{Void},), response.ptr)
end

function get_field(response::HttpResponse, field::AbstractString)
    bytestring(ccall((:sfHttpResponse_getField, libcsfml_network), Ptr{Cchar}, (Ptr{Void}, Ptr{Cchar},), response.ptr, field))
end

function get_status(response::HttpResponse)
    HttpStatus(ccall((:sfHttpResponse_getStatus, libcsfml_network), Int32, (Ptr{Void},), response.ptr))
end

function get_major_version(response::HttpResponse)
    ccall((:sfHttpResponse_getMajorVersion, libcsfml_network), UInt32, (Ptr{Void},), response.ptr)
end

function get_minor_version(response::HttpResponse)
    ccall((:sfHttpResponse_getMinorVersion, libcsfml_network), UInt32, (Ptr{Void},), response.ptr)
end

function get_body(response::HttpResponse)
    bytestring(ccall((:sfHttpResponse_getBody, libcsfml_network), Ptr{Cchar}, (Ptr{Void},), response.ptr))
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
    Http(ccall((:sfHttp_create, libcsfml_network), Ptr{Void}, ()))
end

function destroy(http::Http)
    ccall((:sfHttp_destroy, libcsfml_network), Void, (Ptr{Void},), http.ptr)
end

function set_host(http::Http, host::AbstractString, port::Integer=0)
    ccall((:sfHttp_setHost, libcsfml_network), Void, (Ptr{Void}, Ptr{Cchar}, UInt16), http.ptr, host, port)
end

function send_request(http::Http, request::HttpRequest, timeout::Time=Time(0))
    HttpResponse(ccall((:sfHttp_sendRequest, libcsfml_network), Ptr{Void}, (Ptr{Void}, Ptr{Void}, Time), http.ptr, request.ptr, timeout))
end
