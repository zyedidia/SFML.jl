using SFML

# This example downloads the html for the webpage http://www.sfml-dev.org/learn.php
http = Http()

set_host(http, "http://www.sfml-dev.org")

request = HttpRequest()
set_uri(request, "learn.php")
set_method(request, SFML.HttpGet)

response = send_request(http, request)

status = get_status(response)
if status == SFML.HttpOk
    println("Success!")
    println("Got: $(get_body(response))")
else
    println("Error")
    println(status)
end
