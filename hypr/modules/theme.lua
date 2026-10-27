-- Loads theme/palette.json -- the single source of truth for colors, shared
-- with Quickshell (which parses the same file natively as JSON).

-- Used for any key palette.json lacks (or when it is missing), so a broken palette cannot stop the config from loading
local defaults = {
    bg = "000000ff",
    fg = "C2C4E9ff",
    accent = "6f77b8ff",
    border_active = "6f77b8ff",
    border_inactive = "1a1a1aff",
}

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

return setmetatable(load_palette(), { __index = defaults })
