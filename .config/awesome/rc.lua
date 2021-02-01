-- Check if LuaRocks is installed and lua package through it
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.hotkeys_popup.keys")

-- load custom modules
local shapes = require("modules.shapes")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify(
        {
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
        }
    )
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal(
        "debug::error",
        function(err)
            -- Make sure we don't go into an endless error loop
            if in_error then
                return
            end
            in_error = true

            naughty.notify(
                {
                    preset = naughty.config.presets.critical,
                    title = "Oops, an error happened!",
                    text = tostring(err)
                }
            )
            in_error = false
        end
    )
end
-- }}}

-- {{{ Global Variable definition

-- Initialize the Theme class
local themeDir = gears.filesystem.get_dir("config") .. "themes/nerv/theme.lua"
print("Loading Theme From :" .. themeDir)
beautiful.init(themeDir)
print("Theme successfully loaded")

-- App variable / define path to certain appears
terminal = "xterm"
editor = "code"
editor_cmd = terminal .. " -e vim"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- List of avaliable tiling layout
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral
}

-- }}}

-- {{{

-- }}}

-- Keyboard layout indicator
Keyboardlayout = awful.widget.keyboardlayout()

-- Init top bar
awful.screen.connect_for_each_screen(
    function(s)
        awful.tag({"1", "2", "3", "4", "5", "6", "7", "8"}, s, awful.layout.layouts[1])
        gears.wallpaper.fit(beautiful.wallpaper, s)
        -- Create a taglist widget
    end
)

require("modules.topbar.init")

-- {{{ Mouse binding
root.buttons(
    gears.table.join(
        awful.button(
            {},
            3,
            function()
                Launcher_MainMenu:toggle()
            end
        ),
        awful.button({}, 4, awful.tag.viewnext),
        awful.button({}, 5, awful.tag.viewprev)
    )
)
-- }}}

globalkeys =
    gears.table.join(
    awful.key({modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
    awful.key(
        {modkey},
        "w",
        function()
            Launcher_MainMenu:show()
        end,
        {
            description = "show main menu",
            group = "awesome"
        }
    ),
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
    )
)

root.keys(globalkeys)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
    "mouse::enter",
    function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end
)
