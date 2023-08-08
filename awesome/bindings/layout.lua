local awful = require("awful")
local mod = require("bindings.mod")

local l = require("vars.layout")

awful.keyboard.append_global_keybindings({
	-- master width factor
	awful.key({ mod.super }, l.left, function ()
		awful.tag.incmwfact(0.05)
	end),
	awful.key({ mod.super }, l.right, function ()
		awful.tag.incmwfact(-0.05)
	end),

	-- number of master clients
	awful.key({ modkey, mod.shift }, l.left, function ()
		awful.tag.incnmaster(1, nil, true)
	end),
	awful.key({ modkey, mod.shift   }, l.right, function ()
		awful.tag.incnmaster(-1, nil, true)
	end),

	-- number of columns
	awful.key({ modkey, mod.control }, l.left, function ()
		awful.tag.incncol(1, nil, true)
	end),
	awful.key({ modkey, mod.control }, l.right, function ()
		awful.tag.incncol(-1, nil, true)
	end),

	-- switch layout
	awful.key({ modkey }, "space", function ()
		awful.layout.inc(1)
	end),
	awful.key({ modkey, mod.shift }, "space", function ()
		awful.layout.inc(-1)
	end),
})
