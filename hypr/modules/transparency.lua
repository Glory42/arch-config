-- See-through windows: apps are solid unless listed here, and SUPER + O flips the focused app (every window of its class)
local state_file = (os.getenv("XDG_STATE_HOME") or (os.getenv("HOME") .. "/.local/state")) .. "/hypr-see-through"

-- Window opacity of an app that is see-through; change the numbers here to make windows more or less see-through
local levels = { active = 0.88, inactive = 0.78 }

-- Apps that start see-through: terminals (herdr and tmux run inside them), Vesktop and Spotify
local starts_see_through = {
    "foot", "dropdown", "TUI.float", "Alacritty", "kitty", "com.mitchellh.ghostty", "org.wezfurlong.wezterm",
    "vesktop", "spotify",
}

local M = {}

local default = {}
for _, class in ipairs(starts_see_through) do
    default[class] = true
end

-- What SUPER + O changed (class -> true for see-through, false for solid), kept in the state file across reloads and restarts
local override = {}
local rules = {}

local function see_through(class)
    if override[class] ~= nil then
        return override[class]
    end
    return default[class] == true
end

local function save()
    local file = io.open(state_file, "w")
    if file then
        for class, wanted in pairs(override) do
            file:write((wanted and "+" or "-") .. class .. "\n")
        end
        file:close()
    end
end

-- A window class is matched in full, so the dots and other symbols in it are escaped
local function pattern(class)
    return "^" .. class:gsub("[%^%$%(%)%.%[%]%*%+%-%?|{}\\]", "\\%0") .. "$"
end

local function rule_for(class)
    if not rules[class] then
        rules[class] = hl.window_rule({
            name    = "see-through-" .. class,
            match   = { class = pattern(class) },
            opacity = levels.active .. " override " .. levels.inactive .. " override",
        })
        rules[class]:set_enabled(see_through(class))
    end
    return rules[class]
end

local file = io.open(state_file, "r")
if file then
    for line in file:lines() do
        local sign, class = line:match("^([+-])(.+)$")
        if sign then
            override[class] = sign == "+"
        elseif line ~= "" and line ~= "on" and line ~= "off" then
            override[line] = false
        end
    end
    file:close()
end

for class in pairs(default) do
    rule_for(class)
end
for class in pairs(override) do
    rule_for(class)
end

function M.toggle()
    local window = hl.get_active_window()
    if not window or window.class == "" then
        return
    end
    local class = window.class
    local wanted = not see_through(class)
    if wanted == (default[class] == true) then
        override[class] = nil
    else
        override[class] = wanted
    end
    rule_for(class):set_enabled(wanted)
    save()
end

return M
