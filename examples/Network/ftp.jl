using SFML

function check(r)
    if !isok(r)
        print_with_color(:red, "Error: $(get_status(r))\n")
    end
end

print("Please enter the host address: ")
host = readline(STDIN) |> chomp

print("Please enter your username: ")
username = readline(STDIN) |> chomp

# Don't echo the password in the terminal
print("Please enter your password: ")
@unix_only run(`stty -echo`)
@windows_only print("(Your password will be shown) ")
password = readline(STDIN) |> chomp
@unix_only run(`stty echo`)

println("Connecting...")

ftp = Ftp()
response = connect(ftp, IpAddress(host))
check(response)
if get_status(response) == SFML.FtpConnectionFailed
    println("Failed to connect")
    exit(0)
end
println("Connected")

response = login(ftp, username, password)
check(response)
if get_status(response) == SFML.FtpNotLoggedIn
    println("Failed to log in")
    exit(0)
end
println("Logged in")

println("Possible commands: ls, cd, mkdir, rename, rm, rmdir, download, upload, logout/disconnect/exit")

while true
    response = get_working_directory(ftp)
    check(response)
    print_with_color(:blue, "$(get_directory(response))> ")
    command = split(readline(STDIN) |> strip, r"\s+")

    if command[1] == "ls"
        if length(command) > 1
            dir = command[2]
        else
            dir = "."
        end
        listing = get_directory_listing(ftp, dir)
        check(listing)
        num_files = get_count(listing)
        for i = 0:num_files - 1
            println(get_name(listing, i))
        end
    elseif command[1] == "cd"
        if length(command) > 1
            dir = command[2]
        else
            dir = "~"
        end
        check(change_directory(ftp, dir))
    elseif command[1] == "mkdir"
        if length(command) > 1
            check(create_directory(ftp, command[2]))
        else
            println("mkdir must take one argument")
        end
    elseif command[1] == "rename"
        if length(command) > 2
            check(rename_file(ftp, command[2], command[3]))
        else
            println("rename must take two arguments")
        end
    elseif command[1] == "rm"
        if length(command) > 1
            check(delete_file(ftp, command[2]))
        else
            println("rm must take one argument")
        end
    elseif command[1] == "rmdir"
        if length(command) > 1
            check(delete_directory(ftp, command[2]))
        else
            println("rmdir must take one argument")
        end
    elseif command[1] == "download"
        if length(command) > 1
            if length(command) > 2
                dir = command[3]
            else
                dir = "."
            end
            check(download(ftp, command[2], dir, SFML.FtpBinary))
        else
            println("download must take at least one argument")
        end
    elseif command[1] == "upload"
        if length(command) > 1
            if length(command) > 2
                dir = command[3]
            else
                dir = "."
            end
            check(upload(ftp, command[2], dir, SFML.FtpBinary))
        else
            println("upload must take at least one argument")
        end
    elseif command[1] == "exit" || command[1] == "disconnect" || command[1] == "logout"
        check(disconnect(ftp))
        println("Disconnected")
        exit(0)
    else
        println("Unknown command: $(command[1])")
    end
end
