local beautiful = require("beautiful")
local wibox = require("wibox")
local hotkeys_popup = require("awful.hotkeys_popup")
local awful = require("awful")
local apps = require("configs.apps")
local shapes = require("modules.shapes")

local Launcher_awesomeMenu = {
    {
        "hotkeys",
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end
    },
    {"manual", apps.terminal .. " -e man awesome"},
    {"edit config", apps.editor_cmd .. " " .. awesome.conffile},
    {"restart", awesome.restart},
    {
        "quit",
        function()
            awesome.quit()
        end
    }
}

local menu_awesome = {"awesome", Launcher_awesomeMenu, beautiful.awesome_icon}
local menu_terminal = {"open terminal", apps.terminal}

local Launcher_MainMenu = awful.menu({items = {menu_awesome, menu_terminal}})

local Launcher =
    awful.widget.launcher(
    {
        image = beautiful.awesome_icon,
        menu = Launcher_MainMenu
    }
)

Init_startmenu = function(s)
    s.startmenu =
        wibox(
        {
            screen = s,
            visible = true,
            ontop = false,
            type = "menu",
            width = beautiful.bar_height,
            height = beautiful.bar_height,
            shape = shapes.rounded_rect_shape,
            layout = wibox.container.margin,
            widget = Launcher,
            bg = "#00000000"
        }
    )
    --s.startmenu:struts({top = beautiful.bar_height + 2 * beautiful.bar_gap})
    s.startmenu.x = s.workarea.x + beautiful.bar_gap
    s.startmenu.y = beautiful.bar_gap
end

return Init_startmenu
