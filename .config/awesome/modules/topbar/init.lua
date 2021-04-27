local awful = require("awful")

require("modules.topbar.startmenu")
require("modules.topbar.layoutbox")
require("modules.topbar.desktoplist")
require("modules.topbar.clock")
require("modules.topbar.taskbar")
require("modules.topbar.systray")
require("modules.topbar.sysinfo")


awful.screen.connect_for_each_screen(
    function(s)
        Init_startmenu(s)
        Init_layoutbox(s)
        Init_desktoplist(s)
        Init_clock(s)
        Init_tasklist(s)
        if s.index == 1 then
            Init_systray(s)
        end
        Init_sysinfo(s)
    end
)
