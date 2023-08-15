local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local clock = wibox.widget.textclock("%a %b %d | %l:%M:%S", 1)

screen.connect_signal("request::desktop_decoration", function(s)
	s.prompt = awful.widget.prompt()
	s.mypromptbox = s.prompt

	-- Create a taglist widget
	s.taglist = awful.widget.taglist {
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
		},
		widget_template = {
			{
				{
					{
						{
							{
								id = "index_role",
								widget = wibox.widget.textbox,
							},
							margins = 4,
							widget = wibox.container.margin,
						},
						shape = gears.shape.rounded_rect,
						widget = wibox.container.background,
					},
					{
						id  = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left  = 18,
				right = 18,
				widget = wibox.container.margin
			},
			id = "background_role",
			widget = wibox.container.background,
			-- Add support for hover colors and an index label
			create_callback = function(self, c3, index, objects) --luacheck: no unused args
				self:get_children_by_id("index_role")[1].markup = c3.index
			end,
			update_callback = function(self, c3, index, objects) --luacheck: no unused args
				self:get_children_by_id("index_role")[1].markup = c3.index
			end,
		},
	}

	-- Create a tasklist widget
	s.tasklist = awful.widget.tasklist {
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
				s.taglist,
				s.prompt,
			},
			s.tasklist,
			{
				layout = wibox.layout.fixed.horizontal,
				clock,
				wibox.widget.systray(),
			},
		}
	}
end)

