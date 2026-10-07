--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

------------------
---- WORKSPACES --
------------------

hl.window_rule({
    name      = "browser-to-workspace-3",
    match     = { class = "helium" },
--    workspace = "3 silent",
})

hl.window_rule({
    name              = "zed-to-workspace-1",
    match             = { class = "dev.zed.Zed" },
    workspace         = "1 silent",
    focus_on_activate = false,
})

hl.window_rule({
    -- Spotify must run as a native Wayland window for this to match (see spotify/spotify-flags.conf):
    name      = "spotify-to-workspace-6",
    match     = { class = "spotify" },
    workspace = "5 silent",
})

---------------
---- FLOAT ----
---------------

hl.window_rule({
    -- Picture, video and PDF viewers: in the middle, and never see-through
    name    = "viewers-float",
    match   = { class = "(imv|mpv|org\\.gnome\\.Evince)" },

    float   = true,
    size    = { 875, 600 },
    center  = true,
    opacity = "1 override 1 override",
})

hl.window_rule({
    -- btop and other terminal programs started with `foot --app-id=TUI.float` (see binds.lua)
    name   = "tui-float",
    match  = { class = "TUI\\.float" },

    float  = true,
    size   = { 875, 600 },
    center = true,
})

hl.window_rule({
    -- File pickers and permission prompts from the portal
    name   = "portal-dialogs-float",
    match  = { class = "xdg-desktop-portal-gtk" },

    float  = true,
    size   = { 875, 600 },
    center = true,
})

hl.window_rule({
    name   = "satty-float",
    match  = { class = "com\\.gabm\\.satty" },

    float  = true,
    center = true,
})

hl.window_rule({
    -- Password manager: stays out of screen shares
    name            = "keepassxc-float",
    match           = { class = "org\\.keepassxc\\.KeePassXC" },

    float           = true,
    size            = { 875, 600 },
    center          = true,
    no_screen_share = true,
})

hl.window_rule({
    name   = "localsend-float",
    match  = { class = "org\\.localsend\\.localsend_app" },

    float  = true,
    size   = { 1100, 700 },
    center = true,
})

hl.window_rule({
    name   = "qbittorrent-float",
    match  = { class = "org\\.qbittorrent\\.qBittorrent" },

    float  = true,
    center = true,
})

hl.window_rule({
    -- Steam's windows (store, friends, dialogs, pop-ups) float and are never see-through; no screen lock while a game is fullscreen
    name         = "steam-float",
    match        = { class = "steam" },

    float        = true,
    idle_inhibit = "fullscreen",
    opacity      = "1 override 1 override",
})

hl.window_rule({
    name   = "steam-main-size",
    match  = { class = "steam", title = "Steam" },

    center = true,
    size   = { 1100, 700 },
})

hl.window_rule({
    name  = "steam-friends-size",
    match = { class = "steam", title = "Friends List" },

    size  = { 460, 800 },
})

hl.window_rule({
    -- Games started from Steam run as steam_app_<id>
    name         = "steam-games-solid",
    match        = { class = "steam_app_.*" },

    idle_inhibit = "fullscreen",
    opacity      = "1 override 1 override",
})

hl.window_rule({
    name              = "pip-float",
    match             = { title = "(Picture.?in.?[Pp]icture)" },

    float             = true,
    pin               = true,
    size              = { 600, 338 },
    keep_aspect_ratio = true,
    border_size       = 0,
    opacity           = "1 override 1 override",
    move              = { "(monitor_w-window_w-40)", "(monitor_h*0.04)" },
})

-----------------------
---- DROPDOWN TERMINAL --
-----------------------

hl.workspace_rule({
    workspace = "special:magic",
    on_created_empty = "uwsm-app -- foot --app-id=dropdown",
})

hl.window_rule({
    -- SUPER + S opens the scratchpad, and its first window is this terminal
    name   = "dropdown-terminal",
    match  = { class = "dropdown" },
    float  = true,
    size   = { 875, 600 },
    move   = { "((monitor_w-window_w)/2)", "(monitor_h*0.04)" },
})

---------------------
---- LOOK AND IDLE --
---------------------

hl.window_rule({
    -- Fullscreen windows (video, games) are never see-through
    name    = "fullscreen-solid",
    match   = { fullscreen = true },
    opacity = "1 override 1 override 1 override",
})

hl.layer_rule({
    -- Apollo's panels get the same blur as windows (the click-catcher and screenshot layers do not)
    name         = "apollo-blur",
    match        = { namespace = "apollo-(capsule|launchpad|splashdown|logbook|visor|earthrise)" },
    blur         = true,
    ignore_alpha = 0.3,
})

hl.window_rule({
    -- The browser stays almost opaque when it is not the focused window
    name    = "browser-opacity",
    match   = { class = "helium" },
    opacity = "1.0 0.985",
})

hl.window_rule({
    -- No screen lock or screen off while a video plays fullscreen (Apollo honours this)
    name         = "idle-inhibit-fullscreen",
    match        = { class = "(mpv|helium)" },
    idle_inhibit = "fullscreen",
})

-- Other apps, same shape. Remove the "-- " in front of a block, or copy one and change the class.
--
-- hl.window_rule({
--     name      = "obsidian-to-workspace-4",
--     match     = { class = "md\\.obsidian\\.Obsidian" },
--     workspace = "4 silent",
-- })
--
-- hl.window_rule({
--     name      = "slack-to-workspace-5",
--     match     = { class = "Slack" },
--     workspace = "5 silent",
-- })
--
-- hl.window_rule({
--     name      = "vesktop-to-workspace-5",
--     match     = { class = "vesktop" },
--     workspace = "5 silent",
-- })

---------------------------
---- CLASS SET LATE ----
---------------------------

-- The Minecraft launcher is an XWayland window that gets its class only after it opens, so a rule cannot match it: float it from here, then size and centre it once it has stopped moving itself
local floated = {}
hl.on("window.class", function(window)
    if window.class == "Minecraft Launcher" and not floated[window.address] then
        floated[window.address] = true
        local target = "address:" .. window.address
        hl.dispatch(hl.dsp.window.float({ action = "enable", window = target }))
        hl.timer(function()
            hl.dispatch(hl.dsp.window.resize({ x = 1000, y = 650, relative = false, window = target }))
            hl.dispatch(hl.dsp.window.center({ window = target }))
        end, { timeout = 700, type = "oneshot" })
    end
end)
