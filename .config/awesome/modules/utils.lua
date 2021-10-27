local awful = require("awful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
local apps = require("configs.apps")
local beautiful = require("beautiful")
local menubar = require("menubar")
local gears = require("gears")

-- Make sure everything is as expected
awful.spawn("sed -i '/corner-radius/s/= .*/= 5.0/' /home/obito1903/.config/picom/picom.conf")
awful.spawn("pkill glava")
awful.spawn("picom --experimental-backends")

local Launcher_awesomeMenu = {
    {
        "hotkeys",
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end
    },
    {"manual", apps.terminal .. " -e man awesome"},
    {"edit config", apps.editor .. " " .. awesome.conffile},
    {"restart", awesome.restart},
    {
        "quit",
        function()
            awesome.quit()
        end
    }
}

local devMenu = {
    {"Terminal", apps.terminal},
    {"Editor", apps.editor},
    {"CLI editor", apps.editor_cmd}
}

local menu_awesome = {"awesome", Launcher_awesomeMenu, beautiful.awesome_icon}
local menu_terminal = {"open terminal", apps.terminal}
local menu_dev = {"Dev", devMenu}

local utils

utils = {
    client_volume = function(c, value)
        awful.spawn.easy_async_with_shell(
            "ps -p " .. tostring(c.pid) .. " -o comm=",
            function(out)
                local command =
                    'pacmd list-sink-inputs | tr \'\\n\' \'\\r\' | perl -pe \'s/ *index: ([0-9]+).+?application\\.process.binary = "([^\\r]+)"\\r.+?(?=index:|$)/\\2:\\1\\r/g\' | tr \'\\r\' \'\\n\' | grep -i ' ..
                    out:sub(1, -2) .. "  | cut -d:  -f2"
                awful.spawn.easy_async_with_shell(
                    command,
                    function(out, err)
                        awful.spawn.easy_async_with_shell(
                            "pactl set-sink-input-volume " .. out:sub(1, -2) .. " " .. value .. "%",
                            function(out, err)
                                if err ~= "" then
                                    naughty.notify(
                                        {
                                            text = out .. "Erreur" .. err,
                                            title = "Volume err"
                                            -- screen = utils.notify_screen
                                        }
                                    )
                                end
                            end
                        )
                    end
                )
            end
        )
    end,
    glava = {
        status = false,
        toggle = function()
            if utils.glava.status then
                awful.spawn("pkill glava")
            else
                awful.spawn.with_shell("DRI_PRIME=1 glava -d")
            end
            utils.glava.status = not utils.glava.status
        end
    },
    rounded_corner = {
        status = true,
        toggle = function()
            if utils.rounded_corner.status then
                awful.spawn.with_shell("sed -i '/corner-radius/s/= .*/= 0.0/' $HOME/.config/picom/picom.conf")
            else
                awful.spawn.with_shell("sed -i '/corner-radius/s/= .*/= 5.0/' $HOME/.config/picom/picom.conf")
            end
            utils.rounded_corner.status = not utils.rounded_corner.status
        end
    },
    picom = {
        status = true,
        toggle = function()
            if utils.picom.status then
                awful.spawn("pkill picom")
            else
                awful.spawn("picom --experimental-backends")
            end
            utils.picom.status = not utils.picom.status
        end
    },
    launcher_menu = awful.menu({items = {menu_awesome, menu_dev, menu_terminal}})
}

return utils
