-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Border and shadow colours come from theme/palette.json, window opacity from modules/transparency.lua (per app)
local theme = require("modules.theme")

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 10,

        border_size      =0,

        col              = {
            active_border   = "rgba(" .. theme.border_active .. ")",
            inactive_border = "rgba(" .. theme.border_inactive .. ")",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,

    },

    decoration = {
        rounding         = 12,
        rounding_power   = 4,

        shadow           = {
            enabled      = true,
            range        = 20,
            render_power = 5,
            color        = "rgba(" .. theme.accent:sub(1, 6) .. "10)", -- the accent, soft, so each theme glows its own colour
        },

        blur             = {
            enabled  = true,
            size     = 6,
            passes   = 2,
            vibrancy = 0.6,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("smooth", { type = "bezier", points = { { 0.22, 1 }, { 0.1, 1.1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0.85 }, { 0.25, 1.0 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.08 } } })
hl.curve("linearish", { type = "bezier", points = { { 0.3, 0.0 }, { 0.7, 1.0 } } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })

-- WINDOWS
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "smooth", style = "popin 95%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "smooth", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "quick", style = "popin 90%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "quick" })

-- WORKSPACES
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "smooth", style = "fade" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "smooth", style = "slidefadevert 5%" })

-- LAYERS
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "quick", style = "fade" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "quick", style = "popin 95%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "quick", style = "popin 95%" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 3, bezier = "linearish" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 3, bezier = "linearish" })

-- FADE
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "smooth" })
