local module = {}

local function normalize(url)
    if url:find("github.com") then
        return url:gsub("github.com", "raw.githubusercontent.com"):gsub("/blob/", "/")
    end
    return url
end

function module:Create(data)
    assert(data.Image, "Missing Image URL")

    local url = normalize(data.Image)
    local fileName = "img_" .. tostring(math.random(100000,999999)) .. ".png"

    writefile(fileName, game:HttpGet(url))

    local asset = (getcustomasset or getsynasset)(fileName)

    local img = Instance.new(data.ClassName or "ImageLabel")
    img.BackgroundTransparency = 1
    img.Image = asset

    for k,v in pairs(data) do
        if k ~= "Image" and k ~= "ClassName" then
            pcall(function()
                img[k] = v
            end)
        end
    end

    if data.Parent then
        img.Parent = data.Parent
    end

    task.delay(1, function()
        if isfile and isfile(fileName) then
            pcall(delfile, fileName)
        end
    end)

    return img
end

return module
