local beautiful = require("beautiful")
local wibox = require("wibox")
local shapes = require("modules.shapes")

Init_systray = function(s)
    s.systray =
        wibox(
        {
            screen = s,
            visible = true,
            ontop = false,
            type = "menu",
            width = ((s.workarea.width - s.clock.width) / 2 - s.desktoplist.width - s.layoutbox.width -
                4 * beautiful.bar_gap) /
                3,
            height = beautiful.bar_height,
            shape = shapes.rounded_rect_shape,
            widget = wibox.widget.systray(true)
        }
    )
    --s.tasklist:struts({top = beautiful.bar_height + 2 * beautiful.bar_gap})
    s.systray.x =
        s.workarea.x + s.workarea.width - 3 * beautiful.bar_gap - s.layoutbox.width - s.desktoplist.width -
        s.systray.width
    s.systray.y = beautiful.bar_gap
end

return Init_systray
