------------------
---- Programs ----
------------------

local terminal = "kitty"
local fileManager = "nautilus"
local browser = "zen-browser"
local noctalia = "noctalia msg "

------------------
---- Keybinds ----
------------------

-- Programs
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(noctalia .. "panel-toggle launcher"))

-- Utilities
hl.bind("SUPER + P", hl.dsp.exec_cmd(noctalia .. "screenshot-region"))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(noctalia .. "screenshot-fullscreen"))
hl.bind("SUPER + R", hl.dsp.exec_cmd(noctalia .. "plugin noctalia/screen_recorder:service all toggle"))
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd(noctalia .. "panel-open session"))
hl.bind("SUPER + W", hl.dsp.exec_cmd(noctalia .. "panel-toggle clipboard"))

-- Built-in utilities
hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind(
    "SUPER + SHIFT + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- Move focus
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))

-- Move window
hl.bind("SUPER + CTRL + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + CTRL + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + CTRL + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + CTRL + L", hl.dsp.window.move({ direction = "right" }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + CTRL + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctalia .. "volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noctalia .. "volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(noctalia .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(noctalia .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noctalia .. "brightness-down"))
