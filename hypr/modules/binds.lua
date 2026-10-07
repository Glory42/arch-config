---------------------
---- MY PROGRAMS ----
---------------------
local fileManager = "nautilus"
local browser = "helium-browser"
local browser2 = "chromium"
local editor = "zeditor"
local music = "spotify"

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local see_through = require("modules.transparency")
local home = os.getenv("HOME") or ""

hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("uwsm-app -- xdg-terminal-exec"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(browser .. " --incognito"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd(browser2))
hl.bind(mainMod .. " + ALT + SHIFT + B", hl.dsp.exec_cmd(browser2 .. " --incognito"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("uwsm-app -- foot --app-id=TUI.float btop"))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("uwsm-app -- xdg-terminal-exec herdr"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(music))

-- Apollo -- global shortcuts, answered by the running shell
hl.bind(mainMod .. " + CTRL + W", hl.dsp.global("apollo:capsule-toggle-wifi"))
hl.bind(mainMod .. " + CTRL + B", hl.dsp.global("apollo:capsule-toggle-bt"))
hl.bind(mainMod .. " + CTRL + M", hl.dsp.global("apollo:capsule-toggle-music"))
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.global("apollo:capsule-toggle-quick"))
hl.bind(mainMod .. " + CTRL + T", hl.dsp.global("apollo:capsule-toggle-timer"))
hl.bind(mainMod .. " + CTRL + N", hl.dsp.global("apollo:capsule-toggle-notifications"))
hl.bind(mainMod .. " + CTRL + C", hl.dsp.global("apollo:capsule-toggle-calendar"))
hl.bind(mainMod .. " + CTRL + E", hl.dsp.global("apollo:capsule-toggle-weather"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.global("apollo:capsule-toggle-sound"))
hl.bind(mainMod .. " + CTRL + G", hl.dsp.global("apollo:capsule-toggle-connection"))
hl.bind(mainMod .. " + CTRL + X", hl.dsp.global("apollo:capsule-close"))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.global("apollo:capsule-next"))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.global("apollo:capsule-prev"))

-- Switches
hl.bind(mainMod .. " + CTRL + D", hl.dsp.global("apollo:silence-toggle"))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.global("apollo:nightlight-toggle"))
hl.bind(mainMod .. " + CTRL + I", hl.dsp.global("apollo:awake-toggle"))

hl.bind(mainMod .. " + SPACE", hl.dsp.global("apollo:launchpad-toggle"))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.global("apollo:splashdown-toggle"))
hl.bind("XF86PowerOff", hl.dsp.global("apollo:splashdown-toggle"), { locked = true })
hl.bind(mainMod .. " + CTRL + V", hl.dsp.global("apollo:logbook-toggle"))
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.global("apollo:visor-toggle"))
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.global("apollo:earthrise-toggle"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.global("apollo:airlock-lock"))

-- Screen capture through Apollo's Hasselblad
hl.bind("Print", hl.dsp.global("apollo:hasselblad-screenshot"))
hl.bind("ALT + Print", hl.dsp.global("apollo:hasselblad-record"))
hl.bind("SHIFT + Print", hl.dsp.global("apollo:hasselblad-toggle"))
hl.bind("CTRL + Print", hl.dsp.global("apollo:hasselblad-edit"))
hl.bind(mainMod .. " + Print", hl.dsp.global("apollo:hasselblad-colour"))
hl.bind(mainMod .. " + ALT + comma", hl.dsp.global("apollo:capsule-invoke")) -- run the newest notification's action

hl.bind(mainMod .. " + O", see_through.toggle) -- the focused app see-through or solid
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Workspace cycling
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move window with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "d" }))

-- Window cycling
hl.bind("ALT + TAB", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({ next = false }))
hl.bind("ALT + TAB", hl.dsp.window.bring_to_top())
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.bring_to_top())

-- Resize with SUPER + minus / equal (keycodes 20 and 21, layout independent)
hl.bind(mainMod .. " + code:20", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind(mainMod .. " + code:21", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + code:20", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind(mainMod .. " + SHIFT + code:21", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))

-- Switch workspaces with mainMod + [0-9], move the active window with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("ALT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("ALT + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("ALT + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 1%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("ALT + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 1%-"), { locked = true, repeating = true })

-- Keyboard backlight (bin/kbd-backlight)
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd(home .. "/.local/bin/kbd-backlight up"), { locked = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd(home .. "/.local/bin/kbd-backlight down"), { locked = true })
hl.bind("XF86KbdLightOnOff", hl.dsp.exec_cmd(home .. "/.local/bin/kbd-backlight cycle"), { locked = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
