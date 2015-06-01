@enum(FtpTransferMode,
FtpBinary,
FtpAscii,
FtpEbcdic)

@enum(FtpStatus,
    # 1xx: the requested action is being initiated,
    # expect another reply before proceeding with a new command
    FtpRestartMarkerReply          = 110, # Restart marker reply
    FtpServiceReadySoon            = 120, # Service ready in N minutes
    FtpDataConnectionAlreadyOpened = 125, # Data connection already opened, transfer starting
    FtpOpeningDataConnection       = 150, # File status ok, about to open data connection

    # 2xx: the requested action has been successfully completed
    FtpOk                    = 200, # Command ok
    FtpPointlessCommand      = 202, # Command not implemented
    FtpSystemStatus          = 211, # System status, or system help reply
    FtpDirectoryStatus       = 212, # Directory status
    FtpFileStatus            = 213, # File status
    FtpHelpMessage           = 214, # Help message
    FtpSystemType            = 215, # NAME system type, where NAME is an official system name from the list in the Assigned Numbers document
    FtpServiceReady          = 220, # Service ready for new user
    FtpClosingConnection     = 221, # Service closing control connection
    FtpDataConnectionOpened  = 225, # Data connection open, no transfer in progress
    FtpClosingDataConnection = 226, # Closing data connection, requested file action successful
    FtpEnteringPassiveMode   = 227, # Entering passive mode
    FtpLoggedIn              = 230, # User logged in, proceed. Logged out if appropriate
    FtpFileActionOk          = 250, # Requested file action ok
    FtpDirectoryOk           = 257, # PATHNAME created

    # 3xx: the command has been accepted, but the requested action
    # is dormant, pending receipt of further information
    FtpNeedPassword       = 331, # User name ok, need password
    FtpNeedAccountToLogIn = 332, # Need account for login
    FtpNeedInformation    = 350, # Requested file action pending further information

    # 4xx: the command was not accepted and the requested action did not take place,
    # but the error condition is temporary and the action may be requested again
    FtpServiceUnavailable        = 421, # Service not available, closing control connection
    FtpDataConnectionUnavailable = 425, # Can't open data connection
    FtpTransferAborted           = 426, # Connection closed, transfer aborted
    FtpFileActionAborted         = 450, # Requested file action not taken
    FtpLocalError                = 451, # Requested action aborted, local error in processing
    FtpInsufficientStorageSpace  = 452, # Requested action not taken; insufficient storage space in system, file unavailable

    # 5xx: the command was not accepted and
    # the requested action did not take place
    FtpCommandUnknown          = 500, # Syntax error, command unrecognized
    FtpParametersUnknown       = 501, # Syntax error in parameters or arguments
    FtpCommandNotImplemented   = 502, # Command not implemented
    FtpBadCommandSequence      = 503, # Bad sequence of commands
    FtpParameterNotImplemented = 504, # Command not implemented for that parameter
    FtpNotLoggedIn             = 530, # Not logged in
    FtpNeedAccountToStore      = 532, # Need account for storing files
    FtpFileUnavailable         = 550, # Requested action not taken, file unavailable
    FtpPageTypeUnknown         = 551, # Requested action aborted, page type unknown
    FtpNotEnoughMemory         = 552, # Requested file action aborted, exceeded storage allocation
    FtpFilenameNotAllowed      = 553, # Requested action not taken, file name not allowed

    # 10xx: SFML custom codes
    FtpInvalidResponse  = 1000, # Response is not a valid FTP one
    FtpConnectionFailed = 1001, # Connection with server failed
    FtpConnectionClosed = 1002, # Connection with server closed
    FtpInvalidFile      = 1003  # Invalid file to upload / download
)

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

function get_status(response::FtpListingResponse)
	FtpStatus(ccall(dlsym(libcsfml_network, :sfFtpListingResponse_getStatus), Int32, (Ptr{Void},), response.ptr))
end

function get_message(response::FtpListingResponse)
	bytestring(ccall(dlsym(libcsfml_network, :sfFtpListingResponse_getMessage), Ptr{Cchar}, (Ptr{Void},), response.ptr))
end

function get_count(response::FtpListingResponse)
	ccall(dlsym(libcsfml_network, :sfFtpListingResponse_getCount), Csize_t, (Ptr{Void},), response.ptr)
end

function get_name(response::FtpListingResponse, index::Integer)
	bytestring(ccall(dlsym(libcsfml_network, :sfFtpListingResponse_getName), Ptr{Cchar}, (Ptr{Void}, Csize_t,), response.ptr, index))
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

function get_status(response::FtpDirectoryResponse)
	FtpStatus(ccall(dlsym(libcsfml_network, :sfFtpDirectoryResponse_getStatus), Int32, (Ptr{Void},), response.ptr))
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

function get_status(response::FtpResponse)
	FtpStatus(ccall(dlsym(libcsfml_network, :sfFtpResponse_getStatus), Int32, (Ptr{Void},), response.ptr))
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

function get_directory_listing(ftp::Ftp, directory::String)
	FtpListingResponse(ccall(dlsym(libcsfml_network, :sfFtp_getDirectoryListing), Ptr{Void}, (Ptr{Void}, Ptr{Cchar}), ftp.ptr, pointer(directory)))
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
FtpTransferMode, FtpStatus, get_status
