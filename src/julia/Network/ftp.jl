@enum(FtpTransferMode,
FtpBinary,
FtpAscii,
FtpEbcdic)

type FtpListingResponse
	ptr::Ptr{Void}

	function FtpListingResponse(ptr::Ptr{Void})
		self = new(ptr)
		finalizer(self, destroy)
		self
	end
end

function destroy(response::FtpListingResponse)
	ccall(dlsym(libcsfml_network, :sfFtpListingResponse_destroy), Void, (Ptr{Void},), response.ptr)
end

function isok(response::FtpListingResponse)
	ccall(dlsym(libcsfml_network, :sfFtpListingResponse_isOk), Bool, (Ptr{Void},), response.ptr)
end

function get_message(response::FtpListingResponse)
	bytestring(ccall(dlsym(libcsfml_network, :sfFtpListingResponse_getMessage), Ptr{Cchar}, (Ptr{Void},), response.ptr))
end

function get_count(response::FtpListingResponse)
	ccall(dlsym(libcsfml_network, :sfFtpListingResponse_getCount), Csize_t, (Ptr{Void},), response.ptr)
end

function get_name(response::FtpListingResponse, index::Integer)
	ccall(dlsym(libcsfml_network, :sfFtpListingResponse_getName), Ptr{Cchar}, (Ptr{Void}, Csize_t,), response.ptr, index)
end

type FtpDirectoryResponse
	ptr::Ptr{Void}

	function FtpDirectoryResponse(ptr::Ptr{Void})
		self = new(ptr)
		finalizer(self, destroy)
		self
	end
end

function destroy(response::FtpDirectoryResponse)
	ccall(dlsym(libcsfml_network, :sfFtpDirectoryResponse_destroy), Void, (Ptr{Void},), response.ptr)
end

function isok(response::FtpDirectoryResponse)
	ccall(dlsym(libcsfml_network, :sfFtpDirectoryResponse_isOk), Bool, (Ptr{Void},), response.ptr)
end

function get_message(response::FtpDirectoryResponse)
	bytestring(ccall(dlsym(libcsfml_network, :sfFtpDirectoryResponse_getMessage), Ptr{Cchar}, (Ptr{Void},), response.ptr))
end

function get_directory(response::FtpDirectoryResponse)
	bytestring(ccall(dlsym(libcsfml_network, :sfFtpDirectoryResponse_getDirectory), Ptr{Cchar}, (Ptr{Void},), response.ptr))
end

type FtpResponse
	ptr::Ptr{Void}

	function FtpResponse(ptr::Ptr{Void})
		self = new(ptr)
		finalizer(self, destroy)
		self
	end
end

function destroy(response::FtpResponse)
	ccall(dlsym(libcsfml_network, :sfFtpResponse_destroy), Void, (Ptr{Void},), response.ptr)
end

function isok(response::FtpResponse)
	ccall(dlsym(libcsfml_network, :sfFtpResponse_isOk), Bool, (Ptr{Void},), response.ptr)
end

function get_message(response::FtpResponse)
	bytestring(ccall(dlsym(libcsfml_network, :sfFtpResponse_getMessage), Ptr{Cchar}, (Ptr{Void},), response.ptr))
end

type Ftp
	ptr::Ptr{Void}

	function Ftp(ptr::Ptr{Void})
		self = new(ptr)
		finalizer(self, destroy)
		self
	end
end

function Ftp()
	Ftp(ccall(dlsym(libcsfml_network, :sfFtp_create), Ptr{Void}, ()))
end

function destroy(ftp::Ftp)
	ccall(dlsym(libcsfml_network, :sfFtp_destroy), Void, (Ptr{Void},), ftp.ptr)
end

function connect(ftp::Ftp, server::IpAddress, port::Integer=21, timeout::Time=Time(0))
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_connect), Ptr{Void}, (Ptr{Void}, IpAddress, Uint16, Time), ftp.ptr, server, port, timeout))
end

function login_anonymous(ftp::Ftp)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_loginAnonymous), Ptr{Void}, (Ptr{Void},), ftp.ptr))
end

function login(ftp::Ftp, username::String, password::String)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_login), Ptr{Void}, (Ptr{Void}, Ptr{Cchar}, Ptr{Cchar}), ftp.ptr, pointer(username), pointer(password)))
end

function disconnect(ftp::Ftp)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_disconnect), Ptr{Void}, (Ptr{Void},), ftp.ptr))
end

function keep_alive(ftp::Ftp)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_keepAlive), Ptr{Void}, (Ptr{Void},), ftp.ptr))
end

function get_working_directory(ftp::Ftp)
	FtpDirectoryResponse(ccall(dlsym(libcsfml_network, :sfFtp_getWorkingDirectory), Ptr{Void}, (Ptr{Void},), ftp.ptr))
end

function get_directory_listing(ftp::Ftp)
	FtpListingResponse(ccall(dlsym(libcsfml_network, :sfFtp_getDirectoryListing), Ptr{Void}, (Ptr{Void},), ftp.ptr))
end

function change_directory(ftp::Ftp, dir::String)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_changeDirectory), Ptr{Void}, (Ptr{Void}, Ptr{Cchar},), ftp.ptr, pointer(dir)))
end

# Go to the parent directory
function parent_directory(ftp::Ftp)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_parentDirectory), Ptr{Void}, (Ptr{Void},), ftp.ptr))
end

function create_directory(ftp::Ftp, name::String)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_createDirectory), Ptr{Void}, (Ptr{Void}, Ptr{Cchar},), ftp.ptr, pointer(name)))
end

function delete_directory(ftp::Ftp, name::String)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_deleteDirectory), Ptr{Void}, (Ptr{Void}, Ptr{Cchar},), ftp.ptr, pointer(name)))
end

function rename_file(ftp::Ftp, file::String, newname::String)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_renameFile), Ptr{Void}, (Ptr{Void}, Ptr{Cchar}, Ptr{Cchar}), ftp.ptr, pointer(file), pointer(newname)))
end

function delete_file(ftp::Ftp, name::String)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_deleteFile), Ptr{Void}, (Ptr{Void}, Ptr{Cchar},), ftp.ptr, pointer(name)))
end

function download(ftp::Ftp, distantfile::String, destpath::String, mode::FtpTransferMode)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_download), Ptr{Void}, (Ptr{Void}, Ptr{Cchar}, Ptr{Cchar}, Int32), ftp.ptr, pointer(distantfile), pointer(destpath), Int32(mode)))
end

function upload(ftp::Ftp, localfile::String, destpath::String, mode::FtpTransferMode)
	FtpResponse(ccall(dlsym(libcsfml_network, :sfFtp_upload), Ptr{Void}, (Ptr{Void}, Ptr{Cchar}, Ptr{Cchar}, Int32), ftp.ptr, pointer(localfile), pointer(destpath), Int32(mode)))
end

export upload, download, delete_file, rename_file, delete_directory, create_directory, parent_directory, change_directory,
get_directory_listing, get_working_directory, keep_alive, disconnect, login, login_anonymous, connect, destroy, Ftp,
get_message, isok, FtpResponse, get_directory, get_message, FtpDirectoryResponse, get_name, get_count, FtpListingResponse,
FtpTransferMode
