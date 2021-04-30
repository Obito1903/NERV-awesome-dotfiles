local awful = require("awful");
local gears = require("gears");

for i = 1, 8 do
    Globalkeys = gears.table.join(Globalkeys, -- View tag only.
    awful.key({modkey}, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            tag:view_only()
        end
    end, {description = "view tag #" .. i, group = "Tag Managment"}),
    -- Toggle tag display.
                                  awful.key({modkey, "Control"}, "#" .. i + 9,
                                            function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end, {description = "toggle tag #" .. i, group = "Tag Managment"}),
    -- Move client to tag.
                                  awful.key({modkey, "Shift"}, "#" .. i + 9,
                                            function()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end, {
        description = "move focused client to tag #" .. i,
        group = "Tag Managment"
    }), -- Toggle tag on focused client.
    awful.key({modkey, "Control", "Shift"}, "#" .. i + 9, function()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:toggle_tag(tag)
            end
        end
    end, {
        description = "toggle focused client on tag #" .. i,
        group = "Tag Managment"
    }))
end
