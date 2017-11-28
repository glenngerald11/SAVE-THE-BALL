audiolaunch = audio.loadSound ("blop_sound.mp3")
audioclick = audio.loadSound ("click.mp3")
gamebgmusic = audio.loadStream ("bg.mp3")
 
 
soundisOn = true 
musicisOn = true 
 
audio.reserveChannels (1) 
 
 
function playSFX (soundfile, volumelevel)
 
 	if soundisOn == true then 
local volumelevel = volumelevel or 1.0
audio.play(soundfile)
audio.setVolume(volumelevel, {soundfile} )
end 
end 
 
function playgameMusic (soundfile)
 
if musicisOn == true then 
audio.play (soundfile, {channel = 1, loops = -1 , fadein=2500})
end
 
end
 
function resetMusic (soundfile)
 
if musicisOn == true then 
audio.stop(1)
audio.rewind (gamebgmusic)
end
 
end
 
function pauseMusic (soundfile)
if musicisOn == true then 
audio.pause()
end
end
 
function resumeMusic (channel)
if musicisOn == true then 
audio.resume(channel)
end
end