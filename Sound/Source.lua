local module = {}

local function normalize(url)
    if url:find("github.com") then
        return url:gsub("github.com", "raw.githubusercontent.com"):gsub("/blob/", "/")
    end
    return url
end

function module:Create(data)
    assert(data.Sound, "Missing Sound URL")

    local url = normalize(data.Sound)
    local fileName = "snd_" .. tostring(math.random(100000,999999)) .. ".mp3"
  
    writefile(fileName, game:HttpGet(url))

    local asset = (getcustomasset or getsynasset)(fileName)
    local sound = Instance.new("Sound")
    sound.SoundId = asset

    for k,v in pairs(data) do
        if k ~= "Sound" then
            pcall(function()
                sound[k] = v
            end)
        end
    end
  
    if data.Parent then
        sound.Parent = data.Parent
    end

    if data.AutoPlay then
        sound:Play()
    end

    task.delay(2, function()
        if isfile and isfile(fileName) then
            pcall(delfile, fileName)
        end
    end)

    return sound
end

return module
