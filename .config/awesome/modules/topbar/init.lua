local awful = require("awful")

require("modules.topbar.startmenu")
require("modules.topbar.layoutbox")
require("modules.topbar.desktoplist")
require("modules.topbar.clock")
require("modules.topbar.taskbar")

awful.screen.connect_for_each_screen(
    function(s)
        Init_startmenu(s)
        Init_layoutbox(s)
        Init_desktoplist(s)
        Init_clock(s)
        Init_tasklist(s)
    end
)
