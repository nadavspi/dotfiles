local c = {
    red = "#c72835",
    primary = "#bebad4",
    orange = "#d9a479",
    lightgrey = "#d3d3d3",
    purple = "#5d178f",
    darkpurple = "#1b191f",
    cyan = "#2baec2",
}

theme = {}

theme.font          = "Hack Nerd 16"

theme.bg_normal     = c.darkpurple
theme.bg_focus      = c.purple
theme.bg_urgent     = c.cyan
theme.bg_minimize   = "#444444"
theme.bg_systray    = c.darkpurple

theme.fg_normal     = c.primary
theme.fg_focus      = c.primary
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = 5
theme.border_normal = "#000000"
theme.border_focus  = c.purple
theme.border_marked = c.orange
theme.border_color_floating = c.cyan

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
theme.tasklist_bg_focus = theme.bg_systray
theme.taglist_fg_occupied = c.orange
theme.tasklist_align = "center"
theme.tasklist_disable_icon = true

if os.getenv("HOSTNAME") ~= "shanghai" then
    theme.useless_gap = 10
end

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = 50
theme.menu_width  = 200

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil
theme.systray_icon_spacing = 5

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
