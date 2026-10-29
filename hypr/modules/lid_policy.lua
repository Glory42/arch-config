-- What the laptop screen does, decided from the facts alone so the rules sit in one place; monitors.lua reads the facts and applies the answer
local M = {}

-- `externals` counts the other screens, leaving out one that is going away
function M.decide(lid_closed, externals)
    return {
        laptop_on = not (lid_closed and externals > 0),
        -- logind suspends the moment the last other screen goes with the lid shut, before the laptop screen is back for the lock screen; holding the lid lets it come back first
        hold_lid = externals > 0,
    }
end

return M
