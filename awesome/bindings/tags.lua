local awful = require("awful")
local mod = require("bindings.mod")

awful.keyboard.append_global_keybindings({
	awful.key {
		modifiers   = { modkey },
		keygroup    = "numrow",
		description = "only view tag",
		group       = "tag",
		on_press    = function (index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	},
	awful.key {
		modifiers   = { modkey, mod.control },
		keygroup    = "numrow",
		description = "toggle tag",
		group       = "tag",
		on_press    = function (index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	},
	awful.key {
		modifiers = { modkey, mod.super },
		keygroup    = "numrow",
		description = "move focused client to tag",
		group       = "tag",
		on_press    = function (index)
			if client.focus then
				local tag = client.focus.screen.tags[index]

				if tag then
					client.focus:move_to_tag(tag)
					tag:view_only()
				end
			end
		end,
	},
})
