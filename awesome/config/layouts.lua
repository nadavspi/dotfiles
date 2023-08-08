local awful = require("awful")
local lain = require("lain")

local keyboard_layout = require("vars.layout")

function getLayouts (keyboard_layout)
	if l == "qwerty" then
		return {
			awful.layout.suit.tile.left,
		}
	else
		return {
			awful.layout.suit.tile.left,
		}
	end
end

tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts(getLayouts())
end)
