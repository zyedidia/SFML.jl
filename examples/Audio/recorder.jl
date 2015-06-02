using SFML

recorder = SoundBufferRecorder()

start(recorder)
println("Recording for the next 4 seconds")

sleep(4)

stop(recorder)
println("Done recording")
sound = Sound(get_buffer(recorder))
play(sound)
println("Playing")

while get_status(sound) == SoundStatus.PLAYING
end

println("Done")
