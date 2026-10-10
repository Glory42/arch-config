------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- 1. Main Screen of laptop: Zenbook Monitor (2K+, 2x scale)
local laptop = {
    output   = "eDP-1",
    mode     = "2560x1600@60",
    position = "0x0",
    scale    = "2",
    disabled = false, -- without this a rule does not turn a screen that was disabled back on
}

-- Set while the lid is closed with another screen connected; a reload (every theme change) reads it so the laptop screen stays off
local lid_flag = (os.getenv("XDG_RUNTIME_DIR") or "/tmp") .. "/hypr-lid-closed"

local flag = io.open(lid_flag, "r")
if flag then
    flag:close()
    hl.monitor({ output = laptop.output, disabled = true })
else
    hl.monitor(laptop)
end

-- 2. External Screen: BenQ GW2270, starts where the laptop screen ends (2560 / 2 = 1280)
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "1280x0",
    scale    = "1",
})

-- 3. Any other screen (projector, work monitor): preferred mode, to the right, scale picked by Hyprland
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- Lid: with another screen connected, closing it turns the laptop screen off and opening it turns it on; alone, closing it suspends (Apollo locks first)
local function external_screens()
    local count = 0
    for _, monitor in ipairs(hl.get_monitors()) do
        if monitor.name ~= laptop.output then
            count = count + 1
        end
    end
    return count
end

hl.bind("switch:on:Lid Switch", function()
    if external_screens() > 0 then
        local file = io.open(lid_flag, "w")
        if file then
            file:close()
        end
        hl.monitor({ output = laptop.output, disabled = true })
    else
        hl.exec_cmd("systemctl suspend")
    end
end, { locked = true })

hl.bind("switch:off:Lid Switch", function()
    os.remove(lid_flag)
    hl.monitor(laptop)
    hl.dispatch(hl.dsp.dpms({ action = "enable" }))
end, { locked = true })
