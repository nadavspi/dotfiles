local beautiful = require("beautiful")

local theme_dir = os.getenv("HOME") .. "/.config/awesome/style/themes/theme.lua"
beautiful.init(theme_dir)

require("style.wallpaper")
