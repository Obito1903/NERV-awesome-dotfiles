local awful = require("awful");
local gears = require("gears");

Clientkeys =
    gears.table.join(
    awful.key(
        { modkey, "Shift"    },
        "Right",
        function ()
            awful.tag.incmwfact( 0.01)
        end,
        {
            description = "Grow Right",
            group = "window"
        }
    ),
    awful.key(
        { modkey, "Shift"    },
        "Left",
        function ()
            awful.tag.incmwfact(-0.01)
        end,
        {
            description = "Grow Left",
            group = "window"
        }
    ),
    awful.key(
        { modkey, "Shift"    },
        "Down",
        function ()
            awful.client.incwfact( 0.01)
        end,
        {
            description = "Grow Down",
            group = "window"
        }
    ),
    awful.key(
        { modkey, "Shift"    },
        "Up",
        function ()
            awful.client.incwfact(-0.01)
        end,
        {
            description = "Grow Up",
            group = "window"
        }
    ),
    awful.key(
        {modkey},
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {
            description = "toggle fullscreen",
            group = "window"
        }
    ),
    awful.key(
        {modkey, "Ctrl"},
        "q",
        function(c)
            c:kill()
        end,
        {description = "close", group = "window"}
    ),
    awful.key(
        {modkey},
        "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "minimize", group = "window"}
    )
)
