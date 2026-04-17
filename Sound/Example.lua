local load = loadstring(game:HttpGet("https://raw.githubusercontent.com/Whatttt23/Custom/main/Sound/Source.lua"))()

local snd = load:Create({
    Sound = "https://github.com/xxx/sound.mp3",
    Parent = workspace,
    Volume = 2,
    PlaybackSpeed = 1,
    Looped = false,
    AutoPlay = true
    ... -- The rest are similar to the functions in Roblox
})
