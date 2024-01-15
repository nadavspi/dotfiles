local awful = require("awful")
local user = require("config.user")

return awful.menu({
	items = {
		{ "restart", awesome.restart },
		{ "edit config", user.editor_cmd .. " " .. awesome.conffile },
		{ "quit", function() awesome.quit() end },
	}
})
