using SFML

buffer = SoundBuffer("sound.wav")

sound = Sound()
set_buffer(sound, buffer)

play(sound)

while true
end
