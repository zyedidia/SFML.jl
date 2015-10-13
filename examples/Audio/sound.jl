using SFML

buffer = SoundBuffer("$(Pkg.dir("SFML"))/examples/Audio/sound.wav")

sound = Sound(buffer)
set_loop(sound, true)

play(sound)

while true
end
