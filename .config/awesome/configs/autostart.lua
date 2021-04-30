local awful = require("awful")

awful.spawn("picom")
awful.spawn("nm-applet")
awful.spawn("kdeconnect-indicator")
-- awful.spawn.with_shell("xwinwrap -g 1920x1080 -ov -- mpv --loop=inf -wid WID ~/.wallpapers/nerv.mp4")
