---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "tr, us",
        kb_variant   = ",",
        kb_model     = "",
        kb_options   = "shift:both_capslock_cancel,grp:caps_toggle",
        kb_rules     = "",

        -- xset r rate 200 35;
        repeat_rate = 35,
        repeat_delay = 200,
        numlock_by_default = true,

        follow_mouse = 1,
        sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.4,
            clickfinger_behavior = true,
            disable_while_typing = true,
        },
    },

    misc = {
        key_press_enables_dpms = true,
        mouse_move_enables_dpms = true,
    }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.window_rule({
    name  = "terminal-touchpad-scroll",
    match = { class = "(Alacritty|kitty|foot|org\\.codeberg\\.dnkl\\.foot)" },
    scroll_touchpad = 1.5,
})

hl.window_rule({
    name  = "tag-terminal",
    match = { class = "(Alacritty|kitty|foot|org\\.codeberg\\.dnkl\\.foot)" },
    tag   = "+terminal",
})
-- Per-device overrides go here with hl.device({ name = "...", ... }) once
-- there's a real device to tune -- see
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
