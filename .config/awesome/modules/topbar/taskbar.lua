local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local shapes = require("modules.shapes")

local tasklist_buttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end
    ),
    awful.button(
        {},
        3,
        function()
            awful.menu.client_list({theme = {width = 250}})
        end
    ),
    awful.button(
        {},
        4,
        function()
            awful.client.focus.byidx(1)
        end
    ),
    awful.button(
        {},
        5,
        function()
            awful.client.focus.byidx(-1)
        end
    )
)

Init_tasklist = function(s)
    s.tasklist =
        wibox(
        {
            screen = s,
            visible = true,
            ontop = true,
            type = "menu",
            width = s.workarea.width / 2 - s.clock.width / 2 - s.startmenu.width - beautiful.bar_gap * 3,
            height = beautiful.bar_height,
            shape = shapes.rounded_rect_shape,
            layout = wibox.container.margin,
            bg = "#00000000",
            widget = awful.widget.tasklist {
                screen = s,
                filter = awful.widget.tasklist.filter.currenttags,
                buttons = tasklist_buttons,
                style = {
                    shape = shapes.rounded_rect_shape
                },
                layout = {
                    spacing = beautiful.bar_gap,
                    layout = wibox.layout.flex.horizontal
                },
                -- Notice that there is *NO* wibox.wibox prefix, it is a template,
                -- not a widget instance.
                widget_template = {
                    {
                        {
                            {
                                {
                                    id = "icon_role",
                                    widget = wibox.widget.imagebox
                                },
                                margins = 2,
                                widget = wibox.container.margin
                            },
                            {
                                id = "text_role",
                                widget = wibox.widget.textbox
                            },
                            layout = wibox.layout.fixed.horizontal
                        },
                        left = 10,
                        right = 10,
                        widget = wibox.container.margin
                    },
                    id = "background_role",
                    widget = wibox.container.background
                }
            }
        }
    )
    --s.tasklist:struts({top = beautiful.bar_height + 2 * beautiful.bar_gap})
    s.tasklist.x = s.workarea.x + beautiful.bar_gap * 2 + s.startmenu.width
    s.tasklist.y = beautiful.bar_gap
end

return Init_tasklist
