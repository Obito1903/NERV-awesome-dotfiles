local beautiful = require("beautiful")
local wibox = require("wibox")
local shapes = require("modules.shapes")

Init_clock = function(s)
    s.clock =
        wibox(
        {
            screen = s,
            visible = ShowTopBar,
            ontop = false,
            type = "menu",
            width = 3 * beautiful.segment_base_width,
            height = beautiful.bar_height,
            shape = shapes.rounded_rect_shape
        }
    )
    s.clock:setup {
        spacing = 1,
        {
            wibox.widget.textclock("%a %d, %H:%M"),
            layout = wibox.layout.flex.horizontal,
            point = function(geo, args)
                return {
                    x = (args.parent.width - geo.width) / 2,
                    y = (args.parent.height - geo.height) / 2
                }
            end
        },
        layout = wibox.layout.manual
    }
    --s.clock:struts({top = beautiful.bar_height + 2 * beautiful.bar_gap})
    s.clock.x = s.workarea.x + s.workarea.width / 2 - s.clock.width / 2
    s.clock.y = beautiful.bar_gap
end

return Init_clock
