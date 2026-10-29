-- Apps started from Hyprland run through uwsm-app, so each gets its own systemd scope and outlives a Hyprland or Apollo restart
return function(command)
    return "uwsm-app -- " .. command
end
