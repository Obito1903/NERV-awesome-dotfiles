---------------------------
-- Default awesome theme --
---------------------------
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local screen = require("awful.screen")
local gfs = require("gears.filesystem")
local shapes = require("modules.shapes")
local naughty = require("naughty")

local themes_path = gfs.get_dir("config") .. "themes/"

local dpi = xresources.apply_dpi
local theme = {}

theme.font = "sans 8"

theme.bg_normal = "#8650F230"
theme.bg_focus = "#C0359D30"
theme.bg_urgent = "#F1437560"
theme.bg_minimize = "#6F2EEF20"
theme.bg_systray = "#190F2D"

theme.fg_normal = "#FFFFFF"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.border_width = dpi(0)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
                                taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
                                  taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
theme.notification_border_width = dpi(0)
theme.notification_icon_size = dpi(80)
theme.notification_max_width = screen.focused().geometry.width / 4

theme.notification_border_color = "#00000000"
theme.notification_bg = "#36245860"
naughty.config.presets.critical.bg = "#F1437560"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- Variables set for hotkeys popup
theme.hotkeys_bg = theme.bg_normal
theme.hotkeys_modifiers_fg = "#F14375"
theme.hotkeys_label_fg = "#000000"

theme.bar_height = dpi(25)
theme.segment_base_width = dpi(30)
theme.bar_gap = dpi(5)
theme.useless_gap = dpi(2)

theme.corner_raduis = 0

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path ..
                                         "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path ..
                                        "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path ..
                                            "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path ..
                                           "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive =
    themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive =
    themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active =
    themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active =
    themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive =
    themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive =
    themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active =
    themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active =
    themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive =
    themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive =
    themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active =
    themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active =
    themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive =
    themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive =
    themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active =
    themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active =
    themes_path .. "default/titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path .. "nerv/nerv3.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
-- theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)
theme.awesome_icon = themes_path .. "nerv/icons/nerv_icon2.png"
-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Flat-Remix-Red-Dark"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
