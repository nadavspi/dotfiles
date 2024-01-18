local awful = require("awful")
local mod = require("bindings.mod")
local user = require("config.user")

awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "Return", function ()
		awful.spawn("kitty distrobox enter dotfiles")
	end),

	awful.key({ modkey, mod.shift }, "Return", function ()
		awful.spawn("kitty")
	end),

	awful.key({ modkey }, "b", function ()
		awful.spawn("flatpak run org.mozilla.firefox")
	end),

	awful.key({ mod.control }, "space", function ()
		awful.spawn("rofi -show drun -theme launcher")
	end),

	awful.key({ modkey, mod.control }, "r", awesome.restart),
})
