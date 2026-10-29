-- What the laptop screen does, decided from the facts alone so the rules sit in one place; monitors.lua reads the facts and applies the answer
local M = {}

-- `event` is "load", "lid_closed", "lid_opened", "monitor_added" or "monitor_removed"; `externals` counts the other screens after it
function M.decide(event, lid_closed, externals)
    return {
        laptop_on = not (lid_closed and externals > 0),
        -- logind suspends the moment the last other screen goes with the lid shut, before the laptop screen is back for the lock screen
        hold_lid = externals > 0,
        -- So the lid stays held until the laptop screen is back and locked, then logind suspends
        undock = event == "monitor_removed" and lid_closed and externals == 0,
    }
end

return M
