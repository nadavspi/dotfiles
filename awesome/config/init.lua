require("awful.autofocus")

require("config.autostart")
require("config.layouts")
require("config.mouse")
require("config.notifications")
require("config.rules")
require("config.tags")

return {
	user = require "config.user"
}
