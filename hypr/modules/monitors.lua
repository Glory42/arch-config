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

local lid_policy = require("modules.lid_policy")

-- logind's word on the lid, so a reload (every theme change) keeps the laptop screen as it was
local function lid_closed()
    local reply = io.popen("busctl get-property org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager LidClosed 2>/dev/null")
    if not reply then
        return false
    end
    local closed = reply:read("*a"):find("true") ~= nil
    reply:close()
    return closed
end

-- FALLBACK is Hyprland's stand-in while no real screen is on, so it is not another screen
local function is_external(monitor, removed)
    return monitor.name ~= laptop.output and monitor.name ~= removed and monitor.name ~= "FALLBACK"
end

-- The other screens still connected, leaving out one that is going away
local function external_screens(removed)
    local count = 0
    for _, monitor in ipairs(hl.get_monitors()) do
        if is_external(monitor, removed) then
            count = count + 1
        end
    end
    return count
end

local function release_lid()
    hl.exec_cmd("systemctl --user stop hypr-lid-hold 2>/dev/null")
end

local function apply(decision)
    if decision.laptop_on then
        hl.monitor(laptop)
    else
        hl.monitor({ output = laptop.output, disabled = true })
    end
    -- A user unit so stopping it ends the whole inhibitor, and PartOf so it never outlives the session
    if decision.hold_lid then
        hl.exec_cmd("systemd-run --user --quiet --unit=hypr-lid-hold -p PartOf=graphical-session.target systemd-inhibit --what=handle-lid-switch --who=Hyprland --why='Laptop screen comes back before sleep' sleep infinity 2>/dev/null")
    elseif decision.undock then
        hl.exec_cmd("lid-undock " .. laptop.output)
        -- If lid-undock never finishes, the lid still goes back to logind
        hl.timer(release_lid, { timeout = 8000, type = "oneshot" })
    elseif decision.release_lid then
        release_lid()
    end
end

apply(lid_policy.decide("load", lid_closed(), external_screens()))

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

-- With an external screen connected, these workspaces always live on it
local external_workspaces = { 3, 4, 6, 7 }
local workspace_rules = {}

local function first_external(removed)
    for _, monitor in ipairs(hl.get_monitors()) do
        if is_external(monitor, removed) then
            return monitor.name
        end
    end
end

local function place_external_workspaces(removed)
    local target = first_external(removed)
    for _, rule in pairs(workspace_rules) do
        rule:set_enabled(false)
    end
    if not target then
        return
    end
    for _, id in ipairs(external_workspaces) do
        local key = target .. ":" .. id
        if workspace_rules[key] then
            workspace_rules[key]:set_enabled(true)
        else
            workspace_rules[key] = hl.workspace_rule({ workspace = tostring(id), monitor = target })
        end
        if hl.get_workspace(id) then
            hl.dispatch(hl.dsp.workspace.move({ workspace = id, monitor = target }))
        end
    end
end

place_external_workspaces()

-- FALLBACK coming or going is Hyprland covering a moment with no screen, not a screen being plugged in or out
local function is_fallback(monitor)
    return monitor ~= nil and monitor.name == "FALLBACK"
end

hl.on("monitor.added", function(monitor)
    if is_fallback(monitor) then
        return
    end
    place_external_workspaces()
    apply(lid_policy.decide("monitor_added", lid_closed(), external_screens()))
end)

hl.on("monitor.removed", function(monitor)
    if is_fallback(monitor) then
        return
    end
    local removed = monitor and monitor.name
    place_external_workspaces(removed)
    apply(lid_policy.decide("monitor_removed", lid_closed(), external_screens(removed)))
end)

-- The switch event is the lid's state itself; logind may not have caught up with it yet. Alone, logind suspends (Apollo locks first)
hl.bind("switch:on:Lid Switch", function()
    apply(lid_policy.decide("lid_closed", true, external_screens()))
end, { locked = true })

hl.bind("switch:off:Lid Switch", function()
    apply(lid_policy.decide("lid_opened", false, external_screens()))
    hl.dispatch(hl.dsp.dpms({ action = "enable" }))
end, { locked = true })
