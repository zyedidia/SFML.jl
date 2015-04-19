using SFML

recorder = SoundBufferRecorder()

start(recorder)
println("Recording for the next 4 seconds")

sleep(4)

stop(recorder)
println("Done recording")
buffer = get_buffer(recorder)
sound = Sound()
set_buffer(sound, buffer)
play(sound)
println("Playing")

while true
end
