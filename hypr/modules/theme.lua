-- Loads theme/palette.json -- the single source of truth for colors, shared
-- with Quickshell (which parses the same file natively as JSON).

local function load_palette()
    local path = os.getenv("HOME") .. "/.config/theme/palette.json"
    local f = io.open(path, "r")
    if not f then
        return {}
    end

    local content = f:read("*a")
    f:close()

    local palette = {}
    for key, value in content:gmatch('"([%w_]+)"%s*:%s*"([^"]*)"') do
        palette[key] = value
    end
    return palette
end

return load_palette()
