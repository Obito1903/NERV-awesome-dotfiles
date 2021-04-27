local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local shapes = require("modules.shapes")

local destkoplist_buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(t)
            t:view_only()
        end
    ),
    awful.button(
        {modkey},
        1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button(
        {modkey},
        3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),
    awful.button(
        {},
        4,
        function(t)
            awful.tag.viewnext(t.screen)
        end
    ),
    awful.button(
        {},
        5,
        function(t)
            awful.tag.viewprev(t.screen)
        end
    )
)

Init_desktoplist = function(s)
    s.desktoplist =
        wibox(
        {
            screen = s,
            visible = true,
            ontop = false,
            type = "menu",
            width = 4 * beautiful.segment_base_width,
            height = beautiful.bar_height,
            shape = shapes.rounded_rect_shape,
            widget = awful.widget.taglist {
                id = "desklist",
                screen = s,
                filter = awful.widget.taglist.filter.all,
                buttons = destkoplist_buttons
            }
        }
    )
    --s.desktoplist:struts({top = beautiful.bar_height + 2 * beautiful.bar_gap})
    s.desktoplist.x = s.workarea.x + s.workarea.width - 2 * beautiful.bar_gap - s.layoutbox.width - s.desktoplist.width
    s.desktoplist.y = beautiful.bar_gap
end

return Init_desktoplist
