local mainMod = "SUPER"

local function send_shortcut_once(mods, key)
    return function()
        hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down", window = "activewindow" }))
        hl.timer(function()
            hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up", window = "activewindow" }))
        end, { timeout = 50, type = "oneshot" })
    end
end

local function active_window_is_terminal()
	local window = hl.get_active_window()
	if not window then
		return false
	end

	local tags = window.tags
	if type(tags) ~= "table" then
		return false
	end

	for _, tag in ipairs(tags) do
		if tag:gsub("%*$", "") == "terminal" then
			return true
		end
	end
	return false
end

-- foot only binds Control+Shift+C/V and its Shift+Insert pastes the PRIMARY selection, so it needs other mods than GUI apps
local function universal(default_mods, default_key, terminal_mods, terminal_key)
    return function()
        if not hl.get_active_window() then
            return
        end
        if active_window_is_terminal() then
            send_shortcut_once(terminal_mods, terminal_key)()
        else
            send_shortcut_once(default_mods, default_key)()
        end
    end
end

hl.bind(mainMod .. " + C", universal("CTRL", "C", "CTRL + SHIFT", "C"))
hl.bind(mainMod .. " + V", universal("CTRL", "V", "CTRL + SHIFT", "V"))
-- terminals have no cut, so fall back to copy there
hl.bind(mainMod .. " + X", universal("CTRL", "X", "CTRL + SHIFT", "C"))
