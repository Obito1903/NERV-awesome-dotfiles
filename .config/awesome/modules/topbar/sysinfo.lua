local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local shapes = require("modules.shapes")

local battery_widget = require("modules.topbar.widgets.battery-widget.battery")
local cpu_widget = require("modules.topbar.widgets.cpu-widget.cpu-widget")
local brightness_widget = require("modules.topbar.widgets.brightness-widget.brightness")

Init_sysinfo = function(s)
    local reduceby = 0
    if s.index == 1 then
        reduceby = s.systray.width
    end
    s.sysinfo =
        wibox(
        {
            screen = s,
            visible = true,
            ontop = false,
            type = "menu",
            width = (s.workarea.width - s.clock.width) / 2 - s.desktoplist.width - s.layoutbox.width -
                5 * beautiful.bar_gap -
                reduceby,
            height = beautiful.bar_height,
            shape = shapes.rounded_rect_shape
        }
    )
    s.sysinfo:setup {
        {
            awful.widget.keyboardlayout(),
            layout = wibox.layout.fixed.horizontal
        },
        {
            brightness_widget(
                {
                    path_to_icons = "/usr/share/icons/Flat-Remix-Red-Dark/status/symbolic/display-brightness-symbolic.svg"
                }
            ),
            layout = wibox.layout.fixed.horizontal
        },
        {
            battery_widget(
                {
                    show_current_level = true,
                    path_to_icons = "/usr/share/icons/Flat-Remix-Red-Dark/status/symbolic/"
                }
            ),
            layout = wibox.layout.fixed.horizontal
        },
        {
            cpu_widget(
                {
                    timeout = 5
                }
            ),
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.fixed.horizontal
    }
    --s.tasklist:struts({top = beautiful.bar_height + 2 * beautiful.bar_gap})
    s.sysinfo.x =
        s.workarea.x + s.workarea.width - 4 * beautiful.bar_gap - s.layoutbox.width - s.desktoplist.width - reduceby -
        s.sysinfo.width
    s.sysinfo.y = beautiful.bar_gap
end

return Init_sysinfo
