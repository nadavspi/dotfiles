local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

-- {{{ Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        bg     = "#a0785a",
        widget = {
            {
                image  = gears.filesystem.get_random_file_from_dir(
                    "/mnt/nfs/docs/Archive/10-19 Personal documents/16 Collections/16.03 Wallpapers/art",
                    {".jpg", ".png", ".svg"},
                    true
                ),
                resize = true,
                widget = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        }
    }
end)

gears.timer {
    timeout   = 6*60*60, -- 6 hours
    autostart = true,
    callback  = function()
        for s in screen do
            s:emit_signal("request::wallpaper")
        end
    end,
}
-- }}}
