------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- 1. Ana Ekran: Zenbook Dâhili Monitör (2K+, 2x Ölçeklenmiş)
local laptop = {
    output   = "eDP-1",
    mode     = "2560x1600@60",
    position = "0x0",
    scale    = "2",
}
hl.monitor(laptop)

-- 2. Harici Ekran: BenQ GW2270 (FHD, Laptopun Sağında), starts where the laptop screen ends (2560 / 2 = 1280)
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

-- Lid: with another screen connected, closing it turns the laptop screen off and opening it turns it on
local lid_closed_with_screen = false

hl.bind("switch:on:Lid Switch", function()
    if #hl.get_monitors() > 1 then
        lid_closed_with_screen = true
        hl.monitor({ output = laptop.output, disabled = true })
    else
        hl.dispatch(hl.dsp.global("apollo:airlock-lock"))
        --hl.dispatch(hl.dsp.dpms({ action = "disable" }))
    end
end, { locked = true })

hl.bind("switch:off:Lid Switch", function()
    if lid_closed_with_screen then
        lid_closed_with_screen = false
        hl.monitor(laptop)
    end
    hl.dispatch(hl.dsp.dpms({ action = "enable" }))
end, { locked = true })
