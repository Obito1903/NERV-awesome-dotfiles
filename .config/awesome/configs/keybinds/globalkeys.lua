local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")
local utils = require("modules.utils")

local brightness_widget = require("modules.topbar.widgets.brightness-widget.brightness")
local hotkeys_popup = require("awful.hotkeys_popup")

require("modules.utils")

-- Global keybinding
Globalkeys =
    gears.table.join(
    awful.key(
        {modkey},
        "s",
        hotkeys_popup.show_help,
        {
            description = "Show help",
            group = "Awesome"
        }
    ),
    awful.key({modkey}, "Left", awful.tag.viewprev, {description = "Previous desktop", group = "Tag Navigation"}),
    awful.key(
        {modkey},
        "Right",
        awful.tag.viewnext,
        {
            description = "Next desktop",
            group = "Tag Navigation"
        }
    ),
    awful.key(
        {modkey},
        "BackSpace",
        awful.tag.history.restore,
        {
            description = "Return to previous desktop",
            group = "Tag Navigation"
        }
    ),
    awful.key(
        {"Mod1", "Shift"},
        "Tab",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "Focus previous window", group = "Client Navigation"}
    ),
    awful.key(
        {"Mod1"},
        "Tab",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "Focus next window", group = "Client Navigation"}
    ),
    awful.key(
        {modkey},
        "Tab",
        function()
            awful.spawn("rofi -show window")
        end,
        {description = "Open window switcher", group = "Client Navigation"}
    ),
    awful.key(
        {modkey},
        "u",
        awful.client.urgent.jumpto,
        {
            description = "Focus urgent window",
            group = "Client Navigation"
        }
    ),
    awful.key(
        {modkey, "Control"},
        "Right",
        function()
            awful.client.swap.byidx(1)
        end,
        {
            description = "Swap with next client by index",
            group = "Client Managment"
        }
    ),
    awful.key(
        {modkey, "Control"},
        "Left",
        function()
            awful.client.swap.byidx(-1)
        end,
        {
            description = "Swap with previous client by index",
            group = "Client Managment"
        }
    ),

    awful.key({modkey, "Control"}, "r", awesome.restart, {description = "Reload Awesome", group = "Awesome"}),
    awful.key(
        {modkey},
        "r",
        function()
            awful.spawn("rofi -combi-modi drun,ssh -show-icons -show combi")
        end,
        {description = "Open app launcher", group = "Apps"}
    ),
    awful.key(
        {},
        "Print",
        function()
            awful.spawn("flameshot gui")
        end,
        {description = "Screenshot", group = "Apps"}
    ),
    awful.key(
        {},
        "XF86MonBrightnessUp",
        function()
            awful.spawn("light -A 10")
        end,
        {description = "Increase brightness", group = "System Control"}
    ),
    awful.key(
        {},
        "XF86MonBrightnessDown",
        function()
            awful.spawn("light -U 10")
        end,
        {description = "Decrease brightness", group = "System Control"}
    ),
    awful.key(
        {},
        "XF86AudioRaiseVolume",
        function()
            awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
        end,
        {description = "Increase master volume", group = "System Control"}
    ),
    awful.key(
        {},
        "XF86AudioLowerVolume",
        function()
            awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
        end,
        {description = "Decrease master volume", group = "System Control"}
    ),
    awful.key(
        {modkey, "Shift"},
        "f",
        function()
            ToggleTopBar()
        end,
        {description = "Disable Top bar", group = "UI"}
    ),
    awful.key(
        {modkey, "Control"},
        "Up",
        function()
            beautiful.useless_gap = beautiful.useless_gap + 1
            awful.layout.arrange(awful.screen.focused())
        end,
        {description = "Increase gap", group = "UI"}
    ),
    awful.key(
        {modkey, "Control"},
        "Down",
        function()
            beautiful.useless_gap = beautiful.useless_gap - 1
            awful.layout.arrange(awful.screen.focused())
        end,
        {description = "Decrease gap", group = "UI"}
    ),
    awful.key(
        {modkey, "Control"},
        "b",
        utils.rounded_corner.toggle,
        {
            description = "Toggle round corner",
            group = "Compositor"
        }
    ),
    awful.key({modkey, "Control"}, "p", utils.picom.toggle, {description = "Toggle Compositor", group = "Compositor"}),
    awful.key(
        {modkey, "Mod1"},
        "Down",
        function()
            awful.layout.inc(-1)
        end,
        {description = "Change to previous Layout", group = "Tag Managment"}
    ),
    awful.key(
        {modkey, "Mod1"},
        "Up",
        function()
            awful.layout.inc(1)
        end,
        {description = "Change to next Layout", group = "Tag Managment"}
    ),
    awful.key(
        {modkey, "Control"},
        "n",
        function()
            naughty.config.defaults.screen = awful.screen.focused()
            naughty.notify({text = "This screen is set as default for notify"})
        end,
        {description = "Set default screen for naughty", group = "UI"}
    ),
    awful.key(
        {modkey},
        "g",
        utils.glava.toggle,
        {
            description = "Toggle glave",
            group = "Apps"
        }
    )
)
