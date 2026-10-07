----------------
----  MISC  ----
----------------

local theme = require("modules.theme")

hl.config({
    misc = {
        force_default_wallpaper    = 0,
        disable_hyprland_logo      = true,
        disable_splash_rendering   = true,
        disable_scale_notification = true,
        focus_on_activate          = true,  -- windows that ask for attention get focus (links opening in the browser)
        anr_missed_pings           = 3,
        on_focus_under_fullscreen  = 1,
        initial_workspace_tracking = 0,
        allow_session_lock_restore = true,
        background_color           = "rgba(" .. theme.bg .. ")", -- what shows before a wallpaper is drawn, in the theme's colour
    },

    cursor = {
        hide_on_key_press        = true,  -- cursor disappears while you type
        warp_on_change_workspace = 1,     -- cursor follows you to the new workspace
        inactive_timeout         = 5,     -- cursor hides after three idle seconds
    },

    binds = {
        hide_special_on_workspace_change = true,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    ecosystem = {
        no_update_news = true,
    },
})
