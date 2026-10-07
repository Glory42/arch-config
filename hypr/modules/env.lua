-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- Cursor theme and size come from theme/appearance.json (bin/apply-appearance writes them to GTK too)
local function appearance(key, default)
    local file = io.open(os.getenv("HOME") .. "/.config/theme/appearance.json", "r")
    if not file then
        return default
    end
    local content = file:read("*a")
    file:close()
    return content:match('"' .. key .. '"%s*:%s*"([^"]*)"') or content:match('"' .. key .. '"%s*:%s*(%d+)') or default
end

hl.env("XCURSOR_THEME", appearance("cursor_theme", "Adwaita"))
hl.env("XCURSOR_SIZE", appearance("cursor_size", "24"))
hl.env("HYPRCURSOR_SIZE", appearance("cursor_size", "24"))

-- Wallpaper change animation: awww picks a random transition that lasts one second
hl.env("AWWW_TRANSITION", "random")
hl.env("AWWW_TRANSITION_DURATION", "1")
hl.env("AWWW_TRANSITION_FPS", "60")

-- Force apps onto Wayland --
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")

-- XDG (screen sharing needs these) --
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
