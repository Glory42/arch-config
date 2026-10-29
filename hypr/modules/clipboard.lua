local mainMod = "SUPER"
local terminals = require("modules.terminals")

local function send_shortcut_once(mods, key)
    return function()
        hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down", window = "activewindow" }))
        hl.timer(function()
            hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up", window = "activewindow" }))
        end, { timeout = 50, type = "oneshot" })
    end
end

-- foot only binds Control+Shift+C/V and its Shift+Insert pastes the PRIMARY selection, so it needs other mods than GUI apps
local function universal(default_mods, default_key, terminal_mods, terminal_key)
    return function()
        if not hl.get_active_window() then
            return
        end
        if terminals.is_terminal(hl.get_active_window()) then
            send_shortcut_once(terminal_mods, terminal_key)()
        else
            send_shortcut_once(default_mods, default_key)()
        end
    end
end

hl.bind(mainMod .. " + C", universal("CTRL", "C", "CTRL + SHIFT", "C"))
hl.bind(mainMod .. " + V", universal("CTRL", "V", "CTRL + SHIFT", "V"))
hl.bind(mainMod .. " + X", universal("CTRL", "X", "CTRL + SHIFT", "C")) -- terminals have no cut, so fall back to copy there
