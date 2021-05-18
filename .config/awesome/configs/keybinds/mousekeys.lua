local awful = require("awful")
local gears = require("gears")
local utils = require("modules.utils")

root.buttons(
    gears.table.join(
        awful.button(
            {},
            3,
            function()
                utils.launcher_menu:toggle()
            end
        ),
        awful.button({}, 4, awful.tag.viewnext),
        awful.button({}, 5, awful.tag.viewprev)
    )
)
