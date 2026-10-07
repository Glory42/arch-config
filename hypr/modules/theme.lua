-- Loads theme/palette.json -- the single source of truth for colors, shared
-- with Quickshell (which parses the same file natively as JSON).
--
-- Deliberately NOT a general JSON parser: palette.json is guaranteed to stay
-- a flat object of string values, so a simple pattern match is enough and
-- far less likely to have a subtle bug than a hand-rolled recursive parser.
-- If palette.json ever needs nesting or non-string values, this needs
-- rewriting (or swap in a real JSON library) at that point.

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
