local gears = require("gears")
local beautiful = require("beautiful")

Shapes = {
    rounded_rect_shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, beautiful.corner_raduis)
    end
}

return Shapes
