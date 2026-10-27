-- Terminal window classes, shared by the touchpad scroll and tag rules (input.lua) and see-through (transparency.lua)
local M = {
    classes = {
        "foot", "org.codeberg.dnkl.foot", "dropdown", "TUI.float",
        "Alacritty", "kitty", "com.mitchellh.ghostty", "org.wezfurlong.wezterm",
    },
}

local escaped = {}
for _, class in ipairs(M.classes) do
    table.insert(escaped, (class:gsub("[%^%$%(%)%.%[%]%*%+%-%?|{}\\]", "\\%0")))
end
M.match = "^(" .. table.concat(escaped, "|") .. ")$"

return M
