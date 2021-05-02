local awful = require("awful")
local gears = require("gears")
local utils = require("modules.utils")

Clientkeys =
    gears.table.join(
    awful.key(
        {modkey, "Shift"},
        "Right",
        function()
            awful.tag.incmwfact(0.01)
        end,
        {description = "Grow client right", group = "Tag Layout"}
    ),
    awful.key(
        {modkey, "Shift"},
        "Left",
        function()
            awful.tag.incmwfact(-0.01)
        end,
        {description = "Grow client left", group = "Tag Layout"}
    ),
    awful.key(
        {modkey, "Shift"},
        "Down",
        function()
            awful.client.incwfact(0.01)
        end,
        {description = "Grow client down", group = "Tag Layout"}
    ),
    awful.key(
        {modkey, "Shift"},
        "Up",
        function()
            awful.client.incwfact(-0.01)
        end,
        {description = "Grow client up", group = "Tag Layout"}
    ),
    awful.key(
        {modkey},
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "Toggle Fullscreen", group = "Client Managment"}
    ),
    awful.key(
        {modkey},
        "n",
        function(c)
            c.minimized = true
        end,
        {description = "Minimize", group = "Client Managment"}
    ),
    awful.key(
        {modkey, "Ctrl"},
        "q",
        function(c)
            c:kill()
        end,
        {description = "Close client", group = "Client Managment"}
    ),
    awful.key(
        {modkey},
        "XF86AudioRaiseVolume",
        function(c)
            utils.client_volume(c, "+5")
        end,
        {description = "Increase client volume", group = "Client Managment"}
    ),
    awful.key(
        {modkey},
        "XF86AudioLowerVolume",
        function(c)
            utils.client_volume(c, "-5")
        end,
        {description = "Decrease client volume", group = "Client Managment"}
    )
)
