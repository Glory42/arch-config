-------------------
---- AUTOSTART ----
-------------------

-- uwsm runs Hyprland in a wayland-wm@ unit; without it (the plain "Hyprland" session) this file does uwsm's part
local home = os.getenv("HOME")
local cgroup = io.open("/proc/self/cgroup", "r")
local under_uwsm = cgroup ~= nil and cgroup:read("*a"):find("wayland%-wm@") ~= nil
if cgroup then
    cgroup:close()
end

local env_names = {}
if not under_uwsm then
    local env_file = home .. "/.config/uwsm/env"
    local file = io.open(env_file, "r")
    if file then
        for line in file:lines() do
            local name = line:match("^export%s+([%w_]+)=")
            if name then
                table.insert(env_names, name)
            end
        end
        file:close()
        local values = io.popen(". '" .. env_file .. "' >/dev/null 2>&1; for n in " .. table.concat(env_names, " ") .. "; do printf '%s=%s\\n' \"$n\" \"$(printenv \"$n\")\"; done")
        if values then
            for line in values:lines() do
                local name, value = line:match("^([%w_]+)=(.*)$")
                if name then
                    hl.env(name, value)
                end
            end
            values:close()
        end
    end
end

hl.on("hyprland.start", function()
    if not under_uwsm then
        hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP " .. table.concat(env_names, " ")
            .. " && systemctl --user start apollo.service hyprpolkitagent.service hyprsunset.service")
    end
    hl.exec_cmd(home .. "/.local/bin/apply-appearance") -- cursor, fonts, GTK and icon theme
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("uwsm-app -- udiskie --automount --no-notify --no-tray")
    hl.exec_cmd("uwsm-app -- wl-clip-persist --clipboard regular")
end)
