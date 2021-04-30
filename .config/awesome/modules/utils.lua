local awful = require("awful")
local naughty = require("naughty")

RoundCorner = true
awful.spawn(
    "sed -i '/corner-radius/s/= .*/= 5.0/' /home/obito1903/.config/picom/picom.conf")
ToggleRoundCorner = function()
    if RoundCorner then
        awful.spawn.with_shell(
            "sed -i '/corner-radius/s/= .*/= 0.0/' /home/obito1903/.config/picom/picom.conf")
    else
        awful.spawn.with_shell(
            "sed -i '/corner-radius/s/= .*/= 5.0/' /home/obito1903/.config/picom/picom.conf")
    end
    RoundCorner = not RoundCorner
end

PicomEnable = true
TogglePicom = function()
    if PicomEnable then
        awful.spawn("pkill picom")
    else
        awful.spawn("picom")
    end
    PicomEnable = not PicomEnable
end

local utils

utils = {
    client_volume = function(c, value)
        awful.spawn.easy_async_with_shell(
            "ps -p " .. tostring(c.pid) .. " -o comm=", function(out)
                local command =
                    "pacmd list-sink-inputs | tr '\\n' '\\r' | perl -pe 's/ *index: ([0-9]+).+?application\\.process.binary = \"([^\\r]+)\"\\r.+?(?=index:|$)/\\2:\\1\\r/g' | tr '\\r' '\\n' | grep -i " .. out:sub(1,-2) .. "  | cut -d:  -f2"
                awful.spawn.easy_async_with_shell(command, function(out, err)
                    awful.spawn.easy_async_with_shell(
                        "pactl set-sink-input-volume " .. out:sub(1, -2) .. " " ..
                            value .. "%", function(out, err)
                            if err ~= "" then
                                naughty.notify(
                                    {
                                        text = out .. "Erreur" .. err,
                                        title = "Volume err"
                                    })
                            end

                        end)
                end)
            end)

    end

}

return utils
