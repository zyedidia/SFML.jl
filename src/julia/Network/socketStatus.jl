# baremodule SocketStatus
# 	const DONE = 0
# 	const NOT_READY = 1
# 	const PARTIAL = 2
# 	const DISCONNECTED = 3
# 	const ERROR = 4
# end

@enum(SocketStatus, 
SOCKET_DONE, 
SOCKET_NOT_READY, 
SOCKET_PARTIAL, 
SOCKET_DISCONNECTED, 
SOCKET_ERROR)

export SocketStatus
