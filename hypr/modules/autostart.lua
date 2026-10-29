-------------------
---- AUTOSTART ----
-------------------

local launch = require("modules.launch")

-- uwsm sets the environment (uwsm/env) and starts the session services; this file starts the rest
hl.on("hyprland.start", function()
    hl.exec_cmd("apply-appearance") -- cursor, fonts, GTK and icon theme
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd(launch("udiskie --automount --no-notify --no-tray"))
    hl.exec_cmd(launch("wl-clip-persist --clipboard regular"))
end)
