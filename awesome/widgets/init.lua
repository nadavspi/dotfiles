local awful = require "awful"
local menubar = require "menubar"
local user = require "config.user"

require "widgets.wibar"

menubar.utils.terminal = user.terminal -- Set the terminal for applications that require it

return {
	sysmenu = require "widgets.sysmenu"
}
