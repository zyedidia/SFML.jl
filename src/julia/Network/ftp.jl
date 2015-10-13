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
    ccall((:sfFtpListingResponse_destroy, libcsfml_network), Void, (Ptr{Void},), response.ptr)
end

function isok(response::FtpListingResponse)
    ccall((:sfFtpListingResponse_isOk, libcsfml_network), Bool, (Ptr{Void},), response.ptr)
end

function get_status(response::FtpListingResponse)
    FtpStatus(ccall((:sfFtpListingResponse_getStatus, libcsfml_network), Int32, (Ptr{Void},), response.ptr))
end

function get_message(response::FtpListingResponse)
    bytestring(ccall((:sfFtpListingResponse_getMessage, libcsfml_network), Ptr{Cchar}, (Ptr{Void},), response.ptr))
end

function get_count(response::FtpListingResponse)
    ccall((:sfFtpListingResponse_getCount, libcsfml_network), Csize_t, (Ptr{Void},), response.ptr)
end

function get_name(response::FtpListingResponse, index::Integer)
    bytestring(ccall((:sfFtpListingResponse_getName, libcsfml_network), Ptr{Cchar}, (Ptr{Void}, Csize_t,), response.ptr, index))
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
    ccall((:sfFtpDirectoryResponse_destroy, libcsfml_network), Void, (Ptr{Void},), response.ptr)
end

function isok(response::FtpDirectoryResponse)
    ccall((:sfFtpDirectoryResponse_isOk, libcsfml_network), Bool, (Ptr{Void},), response.ptr)
end

function get_status(response::FtpDirectoryResponse)
    FtpStatus(ccall((:sfFtpDirectoryResponse_getStatus, libcsfml_network), Int32, (Ptr{Void},), response.ptr))
end

function get_message(response::FtpDirectoryResponse)
    bytestring(ccall((:sfFtpDirectoryResponse_getMessage, libcsfml_network), Ptr{Cchar}, (Ptr{Void},), response.ptr))
end

function get_directory(response::FtpDirectoryResponse)
    bytestring(ccall((:sfFtpDirectoryResponse_getDirectory, libcsfml_network), Ptr{Cchar}, (Ptr{Void},), response.ptr))
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
    ccall((:sfFtpResponse_destroy, libcsfml_network), Void, (Ptr{Void},), response.ptr)
end

function isok(response::FtpResponse)
    ccall((:sfFtpResponse_isOk, libcsfml_network), Bool, (Ptr{Void},), response.ptr)
end

function get_status(response::FtpResponse)
    FtpStatus(ccall((:sfFtpResponse_getStatus, libcsfml_network), Int32, (Ptr{Void},), response.ptr))
end

function get_message(response::FtpResponse)
    bytestring(ccall((:sfFtpResponse_getMessage, libcsfml_network), Ptr{Cchar}, (Ptr{Void},), response.ptr))
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
    Ftp(ccall((:sfFtp_create, libcsfml_network), Ptr{Void}, ()))
end

function destroy(ftp::Ftp)
    ccall((:sfFtp_destroy, libcsfml_network), Void, (Ptr{Void},), ftp.ptr)
end

function connect(ftp::Ftp, server::IpAddress, port::Integer=21, timeout::Time=Time(0))
    FtpResponse(ccall((:sfFtp_connect, libcsfml_network), Ptr{Void}, (Ptr{Void}, IpAddress, UInt16, Time), ftp.ptr, server, port, timeout))
end

function login_anonymous(ftp::Ftp)
    FtpResponse(ccall((:sfFtp_loginAnonymous, libcsfml_network), Ptr{Void}, (Ptr{Void},), ftp.ptr))
end

function login(ftp::Ftp, username::AbstractString, password::AbstractString)
    FtpResponse(ccall((:sfFtp_login, libcsfml_network), Ptr{Void}, (Ptr{Void}, Ptr{Cchar}, Ptr{Cchar}), ftp.ptr, username, password))
end

function disconnect(ftp::Ftp)
    FtpResponse(ccall((:sfFtp_disconnect, libcsfml_network), Ptr{Void}, (Ptr{Void},), ftp.ptr))
end

function keep_alive(ftp::Ftp)
    FtpResponse(ccall((:sfFtp_keepAlive, libcsfml_network), Ptr{Void}, (Ptr{Void},), ftp.ptr))
end

function get_working_directory(ftp::Ftp)
    FtpDirectoryResponse(ccall((:sfFtp_getWorkingDirectory, libcsfml_network), Ptr{Void}, (Ptr{Void},), ftp.ptr))
end

function get_directory_listing(ftp::Ftp, directory::AbstractString)
    FtpListingResponse(ccall((:sfFtp_getDirectoryListing, libcsfml_network), Ptr{Void}, (Ptr{Void}, Ptr{Cchar}), ftp.ptr, directory))
end

function change_directory(ftp::Ftp, dir::AbstractString)
    FtpResponse(ccall((:sfFtp_changeDirectory, libcsfml_network), Ptr{Void}, (Ptr{Void}, Ptr{Cchar},), ftp.ptr, dir))
end

# Go to the parent directory
function parent_directory(ftp::Ftp)
    FtpResponse(ccall((:sfFtp_parentDirectory, libcsfml_network), Ptr{Void}, (Ptr{Void},), ftp.ptr))
end

function create_directory(ftp::Ftp, name::AbstractString)
    FtpResponse(ccall((:sfFtp_createDirectory, libcsfml_network), Ptr{Void}, (Ptr{Void}, Ptr{Cchar},), ftp.ptr, name))
end

function delete_directory(ftp::Ftp, name::AbstractString)
    FtpResponse(ccall((:sfFtp_deleteDirectory, libcsfml_network), Ptr{Void}, (Ptr{Void}, Ptr{Cchar},), ftp.ptr, name))
end

function rename_file(ftp::Ftp, file::AbstractString, newname::AbstractString)
    FtpResponse(ccall((:sfFtp_renameFile, libcsfml_network), Ptr{Void}, (Ptr{Void}, Ptr{Cchar}, Ptr{Cchar}), ftp.ptr, file, newname))
end

function delete_file(ftp::Ftp, name::AbstractString)
    FtpResponse(ccall((:sfFtp_deleteFile, libcsfml_network), Ptr{Void}, (Ptr{Void}, Ptr{Cchar},), ftp.ptr, name))
end

function download(ftp::Ftp, distantfile::AbstractString, destpath::AbstractString, mode::FtpTransferMode)
    FtpResponse(ccall((:sfFtp_download, libcsfml_network), Ptr{Void}, (Ptr{Void}, Ptr{Cchar}, Ptr{Cchar}, Int32), ftp.ptr, distantfile, destpath, Int32(mode)))
end

function upload(ftp::Ftp, localfile::AbstractString, destpath::AbstractString, mode::FtpTransferMode)
    FtpResponse(ccall((:sfFtp_upload, libcsfml_network), Ptr{Void}, (Ptr{Void}, Ptr{Cchar}, Ptr{Cchar}, Int32), ftp.ptr, localfile, destpath, Int32(mode)))
end

