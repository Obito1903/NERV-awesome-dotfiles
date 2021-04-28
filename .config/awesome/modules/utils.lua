local awful = require("awful")


RoundCorner = true
awful.spawn("sed -i '/corner-radius/s/= .*/= 5.0/' /home/obito1903/.config/picom/picom.conf")
ToggleRoundCorner = function()
    if RoundCorner then
        awful.spawn.with_shell("sed -i '/corner-radius/s/= .*/= 0.0/' /home/obito1903/.config/picom/picom.conf")
    else
        awful.spawn.with_shell("sed -i '/corner-radius/s/= .*/= 5.0/' /home/obito1903/.config/picom/picom.conf")
    end
    RoundCorner = not RoundCorner
end

PicomEnable = true
TogglePicom = function ()
    if PicomEnable then
        awful.spawn("pkill picom")
    else
        awful.spawn("picom")
    end
    PicomEnable = not PicomEnable
end
