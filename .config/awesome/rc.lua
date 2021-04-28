-- Check if LuaRocks is installed and lua package through it
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
-- local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- local menubar = require("menubar")

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

-- Initialize the Theme class
local themeDir = gears.filesystem.get_dir("config") .. "themes/nerv/theme.lua"
print("Loading Theme From :" .. themeDir)
beautiful.init(themeDir)
print("Theme successfully loaded")

-- Load default app config
local apps = require("configs.apps")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.


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

-- Init top bar {{{
awful.screen.connect_for_each_screen(
    function(s)
        awful.tag({"1", "2", "3", "4", "5", "6", "7", "8"}, s, awful.layout.layouts[1])
        gears.wallpaper.maximized(beautiful.wallpaper, s)
        -- Create a taglist widget
    end
)

require("modules.topbar.init")
-- }}}

-- Load keybindings {{{
modkey = "Mod4"

require("configs.keybinds.mousekeys")
require("configs.keybinds.globalkeys")
require("configs.keybinds.tagrelatedkeys")

root.keys(Globalkeys)

require("configs.keybinds.clientkeys")
-- }}}

-- Load rules
require("configs.rules")

-- Clients and client connect_signal config
require("configs.clients")

-- Start program on load
require("configs.autostart")
