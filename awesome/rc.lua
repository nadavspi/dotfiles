-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification {
		urgency = "critical",
		title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
		message = message
	}
end)


local user = require("config.user")
local mod = require("bindings.mod")
modkey = mod.alt

require("style")
require("config")
require("bindings")
require("widgets")

-- {{{ Wibar

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

screen.connect_signal("request::desktop_decoration", function(s)
	-- Each screen has its own tag table.
	awful.tag({ "web", "notes", "chat", "shell", "5" }, s, awful.layout.layouts[1])

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.all,
		buttons = {
			awful.button({ }, 1, function(t) t:view_only() end),
			awful.button({ modkey }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			awful.button({ }, 3, awful.tag.viewtoggle),
			awful.button({ modkey }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
			awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
			awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
		}
	}

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist {
		screen  = s,
		filter  = awful.widget.tasklist.filter.focused,
	}

	-- Create the wibox
	s.mywibox = awful.wibar {
		position = "bottom",
		screen   = s,
		widget   = {
			layout = wibox.layout.align.horizontal,
			{
				layout = wibox.layout.fixed.horizontal,
				s.mytaglist,
			},
			s.mytasklist,
			{
				layout = wibox.layout.fixed.horizontal,
				mytextclock,
				mykeyboardlayout,
				wibox.widget.systray(),
			},
		}
	}
end)

-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
	awful.button({ }, 3, function () mymainmenu:toggle() end),
	awful.button({ }, 4, awful.tag.viewprev),
	awful.button({ }, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
	-- focus.lua
	awful.key({ modkey }, "n", function()
		awful.client.focus.bydirection("down")
		if client.focus then client.focus:raise() end
	end),
	awful.key({ modkey }, "e", function()
		awful.client.focus.bydirection("up")
		if client.focus then client.focus:raise() end
	end),
	awful.key({ modkey }, "m", function()
		awful.client.focus.bydirection("left")
		if client.focus then client.focus:raise() end
	end),
	awful.key({ modkey }, "i", function()
		awful.client.focus.bydirection("right")
		if client.focus then client.focus:raise() end
	end),

	awful.key({ modkey, mod.super }, "n", function ()
		awful.client.swap.bydirection("down")
	end),
	awful.key({ modkey, mod.super }, "e", function ()
		awful.client.swap.bydirection("up")
	end),
	awful.key({ modkey, mod.super }, "m", function ()
		awful.client.swap.bydirection("left")
	end),
	awful.key({ modkey, mod.super }, "i", function ()
		awful.client.swap.bydirection("right")
	end),

	-- launchers.lua
	awful.key({ modkey }, "Return", function ()
		awful.spawn(user.terminal)
	end),

	awful.key({ modkey }, "b", function ()
		awful.spawn("firefox")
	end),

	awful.key({ mod.control }, "space", function ()
		awful.spawn("rofi -show drun -theme launcher")
	end),

	-- meta.lua
	awful.key({ modkey, mod.control }, "r", awesome.restart),

	-- master width factor
	awful.key({ mod.super }, "i", function ()
		awful.tag.incmwfact(0.05)
	end),
	awful.key({ mod.super }, "m", function ()
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
		awful.tag.incncol( 1, nil, true)
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

-- bindings/mouse.lua
client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({ }, 1, function (c)
			c:activate { context = "mouse_click" }
		end),
		awful.button({ modkey }, 1, function (c)
			c:activate { context = "mouse_click", action = "mouse_move"  }
		end),
		awful.button({ modkey }, 3, function (c)
			c:activate { context = "mouse_click", action = "mouse_resize"}
		end),
	})
end)

-- config/rules.lua
-- {{{ Rules
-- Rules to apply to new clients.
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
		}
	}

	-- Floating clients.
	ruled.client.append_rule {
		id       = "floating",
		rule_any = {
			instance = { "copyq", "pinentry" },
			class    = {
				"Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
				"Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name    = {
				"Event Tester",  -- xev.
			},
			role    = {
				"AlarmWindow",    -- Thunderbird's calendar.
				"ConfigManager",  -- Thunderbird's about:config.
				"pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
			}
		},
		properties = { floating = true }
	}

	ruled.client.append_rule {
		{ rule = { }, properties = { }, callback = awful.client.setslave }
	}
	ruled.client.append_rule {
		rules_any = { class = "firefox"     },
		properties = { tag = "web" }
	}
	ruled.client.append_rule {
		rules_any = { class = "obsidian" },
		properties = { tag = "notes" }
	}
	ruled.client.append_rule {
		rules_any	= { class = "discord" },
		properties = { tag = "3" }
	}
end)
-- }}}

-- notifications.lua
-- {{{ Notifications
ruled.notification.connect_signal('request::rules', function()
	-- All notifications will match this rule.
	ruled.notification.append_rule {
		rule       = { },
		properties = {
			screen           = awful.screen.preferred,
			implicit_timeout = 5,
		}
	}
end)

naughty.connect_signal("request::display", function(n)
	naughty.layout.box { notification = n }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:activate { context = "mouse_enter", raise = false }
end)

