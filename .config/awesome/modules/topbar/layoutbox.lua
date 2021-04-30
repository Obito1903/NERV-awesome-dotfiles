local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local shapes = require("modules.shapes")
local gears = require("gears")

Init_layoutbox = function(s)
    s.layoutbox = wibox({
        screen = s,
        visible = ShowTopBar,
        ontop = false,
        type = "menu",
        width = beautiful.bar_height,
        height = beautiful.bar_height,
        shape = shapes.rounded_rect_shape,
        layout = wibox.container.margin,
        widget = awful.widget.layoutbox.new(s, {
            awful.button({}, 1, function()
                awful.layout.inc(1, s)
            end),
            awful.button({}, 3, function()
                awful.layout.inc(-1, s)
            end),
            awful.button({}, 4, function()
                awful.layout.inc(1, s)
            end),
            awful.button({}, 5, function()
                awful.layout.inc(-1, s)
            end)
        })
    })
    -- s.layoutbox:struts({top = beautiful.bar_height + 2 * beautiful.bar_gap})
    s.layoutbox.x = s.workarea.x + s.workarea.width - beautiful.bar_gap -
                        beautiful.bar_height
    s.layoutbox.y = beautiful.bar_gap
end

return Init_layoutbox
