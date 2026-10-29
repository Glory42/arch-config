-- Terminal window classes, shared by the touchpad scroll rule (input.lua), see-through (transparency.lua) and copy and paste (clipboard.lua)
local M = {
    classes = {
        "foot", "org.codeberg.dnkl.foot", "dropdown", "TUI.float",
        "Alacritty", "kitty", "com.mitchellh.ghostty", "org.wezfurlong.wezterm",
    },
}

local function escape(class)
    return (class:gsub("[%^%$%(%)%.%[%]%*%+%-%?|{}\\]", "\\%0"))
end

-- A window class is matched in full, so the dots and other symbols in it are escaped
function M.pattern(class)
    return "^" .. escape(class) .. "$"
end

local escaped, known = {}, {}
for _, class in ipairs(M.classes) do
    table.insert(escaped, escape(class))
    known[class] = true
end
M.match = "^(" .. table.concat(escaped, "|") .. ")$"

function M.is_terminal(window)
    return window ~= nil and known[window.class] == true
end

return M
