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

-- Init top bar
awful.screen.connect_for_each_screen(
    function(s)
        awful.tag({"1", "2", "3", "4", "5", "6", "7", "8"}, s, awful.layout.layouts[1])
        gears.wallpaper.fit(beautiful.wallpaper, s)
        -- Create a taglist widget
    end
)

require("modules.topbar.init")


-- Load keybindings
require("configs.keybinds.mousekeys")
require("configs.keybinds.globalkeys")
require("configs.keybinds.tagrelatedkeys")

root.keys(Globalkeys)

require("configs.keybinds.clientkeys")



awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = Clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },
    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry"
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester" -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    },
    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = {"normal", "dialog"}
        },
        properties = {titlebars_enabled = true}
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}

-- Signal function to execute when a new client appears.
client.connect_signal(
    "manage",
    function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
-- client.connect_signal(
--     "request::titlebars",
--     function(c)
--         -- buttons for the titlebar
--         local buttons =
--             gears.table.join(
--             awful.button(
--                 {},
--                 1,
--                 function()
--                     c:emit_signal("request::activate", "titlebar", {raise = true})
--                     awful.mouse.client.move(c)
--                 end
--             ),
--             awful.button(
--                 {},
--                 3,
--                 function()
--                     c:emit_signal("request::activate", "titlebar", {raise = true})
--                     awful.mouse.client.resize(c)
--                 end
--             )
--         )

--         awful.titlebar(c):setup {
--             {
--                 -- Left
--                 awful.titlebar.widget.iconwidget(c),
--                 buttons = buttons,
--                 layout = wibox.layout.fixed.horizontal
--             },
--             {
--                 -- Middle
--                 {
--                     -- Title
--                     align = "center",
--                     widget = awful.titlebar.widget.titlewidget(c)
--                 },
--                 buttons = buttons,
--                 layout = wibox.layout.flex.horizontal
--             },
--             {
--                 -- Right
--                 awful.titlebar.widget.floatingbutton(c),
--                 awful.titlebar.widget.maximizedbutton(c),
--                 awful.titlebar.widget.stickybutton(c),
--                 awful.titlebar.widget.ontopbutton(c),
--                 awful.titlebar.widget.closebutton(c),
--                 layout = wibox.layout.fixed.horizontal()
--             },
--             layout = wibox.layout.align.horizontal
--         }
--     end
-- )

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
    "mouse::enter",
    function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end
)

-- awful.spawn("picom")
-- awful.spawn.easy_async_with_shell("picom", function()
    -- awful.spawn.easy_async_with_shell("xwinwrap -g 1920x1080 -ov -- mpv --loop=inf -wid WID ~/.wallpapers/nerv.mp4")
-- end)
awful.spawn("nm-applet")
awful.spawn("kdeconnect-indicator")
--awful.spawn.with_shell("xwinwrap -g 1920x1080 -ov -- mpv --loop=inf -wid WID ~/.wallpapers/nerv.mp4")
