-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("qs -p " .. os.getenv("HOME") .. "/.config/quickshell/shell.qml")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("systemctl --user start hyprsunset.service")
    hl.exec_cmd(os.getenv("HOME") .. "/.local/bin/apply-appearance") -- cursor, fonts, GTK and icon theme
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd(os.getenv("HOME") .. "/.local/bin/lid-watch") -- keeps the laptop panel right when the lid or the screens change
    hl.exec_cmd("uwsm-app -- udiskie --automount --no-notify --no-tray")
    hl.exec_cmd("uwsm-app -- wl-clip-persist --clipboard regular")
end)
