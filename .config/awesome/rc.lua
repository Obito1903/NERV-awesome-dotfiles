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

local brightness_widget = require("modules.topbar.widgets.brightness-widget.brightness")

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

-- Global keybinding
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
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 8 do
    globalkeys =
        gears.table.join(
        globalkeys,
        -- View tag only.
        awful.key(
            {modkey},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #" .. i, group = "tag"}
        ),
        -- Toggle tag display.
        awful.key(
            {modkey, "Control"},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key(
            {modkey, "Shift"},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #" .. i, group = "tag"}
        ),
        -- Toggle tag on focused client.
        awful.key(
            {modkey, "Control", "Shift"},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"}
        )
    )
end

root.keys(globalkeys)

--Client keybinding
clientkeys =
    gears.table.join(
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

awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
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
client.connect_signal(
    "request::titlebars",
    function(c)
        -- buttons for the titlebar
        local buttons =
            gears.table.join(
            awful.button(
                {},
                1,
                function()
                    c:emit_signal("request::activate", "titlebar", {raise = true})
                    awful.mouse.client.move(c)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    c:emit_signal("request::activate", "titlebar", {raise = true})
                    awful.mouse.client.resize(c)
                end
            )
        )

        awful.titlebar(c):setup {
            {
                -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout = wibox.layout.fixed.horizontal
            },
            {
                -- Middle
                {
                    -- Title
                    align = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            {
                -- Right
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
    "mouse::enter",
    function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end
)

awful.spawn("picom")
