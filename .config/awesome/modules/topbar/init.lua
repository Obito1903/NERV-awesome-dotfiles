local awful = require("awful")

require("modules.topbar.startmenu")
require("modules.topbar.layoutbox")
require("modules.topbar.desktoplist")
require("modules.topbar.clock")
require("modules.topbar.taskbar")
require("modules.topbar.systray")
require("modules.topbar.sysinfo")

ShowTopBar = true

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

ToggleTopBar = function ()
    s = awful.screen.focused()
    s.desktoplist.visible = not s.desktoplist.visible
    s.clock.visible = not s.clock.visible
    s.layoutbox.visible = not s.layoutbox.visible
    s.startmenu.visible = not s.startmenu.visible
    s.sysinfo.visible = not s.sysinfo.visible
    s.systray.visible = not s.systray.visible
    s.tasklist.visible = not s.tasklist.visible
end
