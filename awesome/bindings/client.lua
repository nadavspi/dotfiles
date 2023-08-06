local awful = require("awful")
local mod = require("bindings.mod")

client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		awful.key({ modkey }, "f", function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end),
		awful.key({ modkey, mod.shift }, "q", function (c)
			c:kill()
		end),
		awful.key({ modkey, mod.control }, "space", awful.client.floating.toggle),
		awful.key({ modkey, mod.super }, "Return", function (c)
			c:swap(awful.client.getmaster())
		end),
	})
end)

