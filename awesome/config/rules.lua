local awful = require("awful")
local ruled = require("ruled")

ruled.client.connect_signal("request::rules", function()
	-- All clients will match this rule.
	ruled.client.append_rule({
		id = "global",
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
		callback = awful.client.setslave,
	})

	ruled.client.append_rule({
		id = "floating",
		rule_any = {
			instance = { "copyq", "pinentry" },
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"Sxiv",
				"Tor Browser",
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},
			name = {
				"Event Tester", -- xev.
			},
		},
		properties = { floating = true },
	})
end)

ruled.client.append_rule({
	rule = { class = "firefox" },
	properties = { tag = "firefox" },
})
ruled.client.append_rule({
	rule = { class = "discord" },
	properties = { tag = "discord" },
})
ruled.client.append_rule({
	rule = { class = "kitty" },
	properties = { tag = "kitty" },
})
ruled.client.append_rule({
	rule = { class = "obsidian" },
	properties = { tag = "notes" },
})
ruled.client.append_rule({
	rule = { class = "mpv" },
	properties = { tag = "mpv" },
})
ruled.client.append_rule({
	rule = { class = "Anki" },
	properties = { tag = "anki" },
})
