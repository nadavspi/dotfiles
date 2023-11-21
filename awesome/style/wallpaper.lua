local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

-- {{{ Wallpaper
screen.connect_signal("request::wallpaper", function(s)
	local image = gears.filesystem.get_random_file_from_dir(
		"/mnt/docs/Archive/10-19 Personal documents/16 Collections/16.03 Wallpapers/art",
		{".jpg", ".png", ".svg"},
		true
	)
	awful.spawn('feh --bg-max --randomize --image-bg "#a0785a" ' .. string.gsub(image, ' ', '\\ '))
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
