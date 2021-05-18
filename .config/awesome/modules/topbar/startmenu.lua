local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local shapes = require("modules.shapes")
local utils = require("modules.utils")

local Launcher =
    awful.widget.launcher(
    {
        image = beautiful.awesome_icon,
        menu = utils.launcher_menu
    }
)

Init_startmenu = function(s)
    s.startmenu =
        wibox(
        {
            screen = s,
            visible = ShowTopBar,
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
    -- s.startmenu:struts({top = beautiful.bar_height + 2 * beautiful.bar_gap})
    s.startmenu.x = s.workarea.x + beautiful.bar_gap
    s.startmenu.y = beautiful.bar_gap
end

return Init_startmenu
