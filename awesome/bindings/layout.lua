local awful = require("awful")
local mod = require("bindings.mod")

awful.keyboard.append_global_keybindings({
	-- master width factor
	awful.key({ mod.super }, "m", function ()
		awful.tag.incmwfact(0.05)
	end),
	awful.key({ mod.super }, "i", function ()
		awful.tag.incmwfact(-0.05)
	end),

	-- number of master clients
	awful.key({ modkey, mod.shift }, "m", function ()
		awful.tag.incnmaster(1, nil, true)
	end),
	awful.key({ modkey, mod.shift   }, "i", function ()
		awful.tag.incnmaster(-1, nil, true)
	end),

	-- number of columns
	awful.key({ modkey, mod.control }, "m", function ()
		awful.tag.incncol(1, nil, true)
	end),
	awful.key({ modkey, mod.control }, "i", function ()
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
