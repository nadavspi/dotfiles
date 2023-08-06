local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local user = require("config.user")
local wibox = require("wibox")

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
	{ "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ "manual", user.terminal .. " -e man awesome" },
	{ "edit config", user.editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{ "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({
	items = {
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "open terminal", user.terminal }
	}
})

mylauncher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = user.terminal -- Set the terminal for applications that require it
-- }}}

