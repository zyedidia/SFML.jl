using SFML

buffer = SoundBuffer("sound.wav")

sound = Sound(buffer)
set_loop(sound, true)

play(sound)

while true
end
