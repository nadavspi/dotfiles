local awful = require("awful")
local mod = require("bindings.mod")
local user = require("config.user")

awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "Return", function ()
		awful.spawn(user.terminal)
	end),

	awful.key({ modkey }, "b", function ()
		awful.spawn("firefox")
	end),

	awful.key({ mod.control }, "space", function ()
		awful.spawn("rofi -show drun -theme launcher")
	end),

	awful.key({ modkey, mod.control }, "r", awesome.restart),
})
