using SFML

buffer = SoundBuffer("sound.wav")

sound = Sound()
set_buffer(sound, buffer)
set_loop(sound, true)

play(sound)

while true
end
