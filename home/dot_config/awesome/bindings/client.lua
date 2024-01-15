local awful = require("awful")
local mod = require("bindings.mod")

local l = require("vars.layout")

client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		awful.key({ modkey }, "f", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end),
		awful.key({ modkey, mod.shift }, "q", function(c)
			c:kill()
		end),
		awful.key({ modkey, mod.control }, "space", awful.client.floating.toggle),
		awful.key({ modkey, mod.super }, "Return", function(c)
			c:swap(awful.client.getmaster())
		end),
		awful.key({ modkey, "Shift" }, "m",
		function (c)
			c.maximized = false
			c.maximized_vertical = false
			c.maximized_horizontal = false
			c:raise()
		end),
	})
end)

awful.keyboard.append_global_keybindings({

	awful.key({ modkey }, l.down, function()
		awful.client.focus.bydirection("down")
		if client.focus then
			client.focus:raise()
		end
	end),
	awful.key({ modkey }, l.up, function()
		awful.client.focus.bydirection("up")
		if client.focus then
			client.focus:raise()
		end
	end),
	awful.key({ modkey }, l.left, function()
		if mouse.screen.selected_tag.layout.name == "max" then
			awful.client.focus.byidx(-1)
		else
			awful.client.focus.bydirection("left")
			if client.focus then
				client.focus:raise()
			end
		end
	end),
	awful.key({ modkey }, l.right, function()
		if mouse.screen.selected_tag.layout.name == "max" then
			awful.client.focus.byidx(-1)
		else
			awful.client.focus.bydirection("right")
			if client.focus then
				client.focus:raise()
			end
		end
	end),

	awful.key({ modkey, mod.super }, l.down, function()
		awful.client.swap.bydirection("down")
	end),
	awful.key({ modkey, mod.super }, l.up, function()
		awful.client.swap.bydirection("up")
	end),
	awful.key({ modkey, mod.super }, l.left, function()
		awful.client.swap.bydirection("left")
	end),
	awful.key({ modkey, mod.super }, l.right, function()
		awful.client.swap.bydirection("right")
	end),
})
