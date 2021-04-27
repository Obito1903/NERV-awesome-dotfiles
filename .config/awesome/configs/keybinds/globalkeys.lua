local awful = require("awful");
local gears = require("gears");

local brightness_widget = require("modules.topbar.widgets.brightness-widget.brightness")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Global keybinding
Globalkeys =
    gears.table.join(
    awful.key({modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
    -- awful.key(
    --     {modkey},
    --     "w",
    --     function()
    --         Launcher_MainMenu:show()
    --     end,
    --     {
    --         description = "show main menu",
    --         group = "awesome"
    --     }
    -- ),
    awful.key(
        {modkey},
        "Left",
        awful.tag.viewprev,
        {
            description = "previous desktop",
            group = "virtual desktop"
        }
    ),
    awful.key({modkey}, "Right", awful.tag.viewnext, {description = "next desktop", group = "virtual desktop"}),
    awful.key(
        {modkey},
        "BackSpace",
        awful.tag.history.restore,
        {
            description = "return to previous desktop",
            group = "virtual desktop"
        }
    ),
    awful.key(
        {modkey, "Mod1"},
        "Right",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next window", group = "window"}
    ),
    awful.key(
        {modkey, "Mod1"},
        "Left",
        function()
            awful.client.focus.byidx(-1)
        end,
        {
            description = "focus previous window",
            group = "window"
        }
    ),
    awful.key(
        {"Mod1"},
        "Tab",
        function()
            awful.client.focus.byidx(1)
        end,
        {
            description = "focus next window",
            group = "window"
        }
    ),
    awful.key(
        {modkey},
        "Tab",
        function()
            awful.spawn("rofi -show window")
        end,
        {
            description = "open window switcher",
            group = "window"
        }
    ),
    awful.key({modkey}, "u", awful.client.urgent.jumpto, {description = "focus urgent window", group = "window"}),
    awful.key(
        {modkey, "Mod1"},
        "Up",
        function()
            awful.screen.focus_relative(1)
        end,
        {
            description = "focus on next screen",
            group = "screen"
        }
    ),
    awful.key(
        {modkey, "Mod1"},
        "Down",
        function()
            awful.screen.focus_relative(-1)
        end,
        {
            description = "focus on previous screen",
            group = "screen"
        }
    ),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "window"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "window"}),
    awful.key({modkey, "Control"}, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
    awful.key(
        {modkey},
        "r",
        function()
            awful.spawn("rofi -combi-modi drun,ssh -show-icons -show combi")
        end,
        {
            description = "Open app launcher",
            group = "apps"
        }
    ),
    awful.key(
        {},
        "Print",
        function()
            awful.spawn("flameshot gui")
        end,
        {
            description = "Screenshot",
            group = "apps"
        }
    ),
    awful.key(
        {},
        "XF86MonBrightnessUp",
        function()
            brightness_widget:inc()
        end,
        {description = "increase brightness", group = "custom"}
    ),
    awful.key(
        {},
        "XF86MonBrightnessUp",
        function()
            brightness_widget:dec()
        end,
        {description = "decrease brightness", group = "custom"}
    ),
    awful.key(
        {},
        "XF86AudioRaiseVolume",
        function()
            awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
        end,
        {description = "increase brightness", group = "custom"}
    ),
    awful.key(
        {},
        "XF86AudioLowerVolume",
        function()
            awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
        end,
        {description = "decrease brightness", group = "custom"}
    )
)
