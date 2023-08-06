local awful = require("awful")
local lain = require("lain")

tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		lain.layout.centerwork,
		awful.layout.suit.tile.left,
	})
end)
