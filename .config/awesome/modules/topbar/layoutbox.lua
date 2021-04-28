local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local shapes = require("modules.shapes")

Init_layoutbox = function(s)
    s.layoutbox =
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
            widget = awful.widget.layoutbox(s)
        }
    )
    --s.layoutbox:struts({top = beautiful.bar_height + 2 * beautiful.bar_gap})
    s.layoutbox.x = s.workarea.x + s.workarea.width - beautiful.bar_gap - beautiful.bar_height
    s.layoutbox.y = beautiful.bar_gap
end

return Init_layoutbox
