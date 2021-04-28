local awful = require("awful")

-- awful.spawn("picom")
-- awful.spawn.easy_async_with_shell("picom", function()
    -- awful.spawn.easy_async_with_shell("xwinwrap -g 1920x1080 -ov -- mpv --loop=inf -wid WID ~/.wallpapers/nerv.mp4")
-- end)
awful.spawn("nm-applet")
awful.spawn("kdeconnect-indicator")
--awful.spawn.with_shell("xwinwrap -g 1920x1080 -ov -- mpv --loop=inf -wid WID ~/.wallpapers/nerv.mp4")
