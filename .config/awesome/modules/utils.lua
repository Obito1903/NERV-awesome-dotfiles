local awful = require("awful")
local naughty = require("naughty")

-- Make sure everything is as expected
awful.spawn(
    "sed -i '/corner-radius/s/= .*/= 5.0/' /home/obito1903/.config/picom/picom.conf")
awful.spawn("pkill glava")
awful.spawn("picom")

local utils

utils = {
    client_volume = function(c, value)
        awful.spawn.easy_async_with_shell(
            "ps -p " .. tostring(c.pid) .. " -o comm=", function(out)
                local command =
                    "pacmd list-sink-inputs | tr '\\n' '\\r' | perl -pe 's/ *index: ([0-9]+).+?application\\.process.binary = \"([^\\r]+)\"\\r.+?(?=index:|$)/\\2:\\1\\r/g' | tr '\\r' '\\n' | grep -i " ..
                        out:sub(1, -2) .. "  | cut -d:  -f2"
                awful.spawn.easy_async_with_shell(command, function(out, err)
                    awful.spawn.easy_async_with_shell(
                        "pactl set-sink-input-volume " .. out:sub(1, -2) .. " " ..
                            value .. "%", function(out, err)
                            if err ~= "" then
                                naughty.notify(
                                    {
                                        text = out .. "Erreur" .. err,
                                        title = "Volume err"
                                        -- screen = utils.notify_screen
                                    })
                            end

                        end)
                end)
            end)

    end,
    glava = {
        status = false,
        toggle = function()
            if utils.glava.status then
                awful.spawn("pkill glava")
            else
                awful.spawn("glava -d")
            end
            utils.glava.status = not utils.glava.status
        end
    },

    rounded_corner = {
        status = true,
        toggle = function()
            if utils.rounded_rect.status then
                awful.spawn.with_shell(
                    "sed -i '/corner-radius/s/= .*/= 0.0/' /home/obito1903/.config/picom/picom.conf")
            else
                awful.spawn.with_shell(
                    "sed -i '/corner-radius/s/= .*/= 5.0/' /home/obito1903/.config/picom/picom.conf")
            end
            utils.rounded_rect.status = not utils.rounded_rect.status
        end
    },

    picom = {
        status = true,
        toggle = function()
            if utils.picom.status then
                awful.spawn("pkill picom")
            else
                awful.spawn("picom")
            end
            utils.picom.status = not utils.picom.status
        end
    }
}

return utils
