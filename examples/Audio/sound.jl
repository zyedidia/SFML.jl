using SFML

buffer = SoundBuffer(joinpath(dirname(@__FILE__),"sound.wav"))

sound = Sound(buffer)
set_loop(sound, true)

play(sound)

while true
end
