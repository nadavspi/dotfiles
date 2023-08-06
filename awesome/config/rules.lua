local awful = require("awful")
local ruled = require("ruled")

ruled.client.connect_signal("request::rules", function()
	-- All clients will match this rule.
	ruled.client.append_rule {
		id         = "global",
		rule       = { },
		properties = {
			focus     = awful.client.focus.filter,
			raise     = true,
			screen    = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen
		},
		callback = awful.client.setslave
	}

	ruled.client.append_rule {
		id       = "floating",
		rule_any = {
			instance = { "copyq", "pinentry" },
			class    = {
				"Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
				"Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
			},
			name    = {
				"Event Tester",  -- xev.
			},
		},
		properties = { floating = true }
	}


-- 	ruled.client.append_rule {
-- 		rules_any = { class = "firefox"     },
-- 		properties = { tag = "web" }
-- 	}
-- 	ruled.client.append_rule {
-- 		rules_any = { class = "Obsidian" },
-- 		properties = { tag = "notes" }
-- 	}
-- 	ruled.client.append_rule {
-- 		rules_any	= { class = "discord" },
-- 		properties = { tag = "chat" }
-- 	}
end)
