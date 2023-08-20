local awful = require("awful")
local mod = require("bindings.mod")

local function delete_tag()
	local t = awful.screen.focused().selected_tag
	if not t then return end
	t:delete()
end

local function add_tag()
	awful.tag.add("new",
	{
		screen = awful.screen.focused(),
		layout = awful.layout.layouts[1],
	}):view_only()
end

local function rename_tag()
	awful.prompt.run {
		prompt       = "New tag name: ",
		textbox      = awful.screen.focused().prompt.widget,
		exe_callback = function(new_name)
			if not new_name or #new_name == 0 then return end

			local t = awful.screen.focused().selected_tag
			if t then
				t.name = new_name
			end
		end
	}
end

local function move_to_new_tag()
    local c = client.focus
    if not c then return end

    local t = awful.tag.add(c.class,{ screen= c.screen })
    c:tags({ t })
    t:view_only()
end


awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "a", add_tag),
	awful.key({ modkey, mod.shift }, "a", delete_tag),
	awful.key({ modkey }, "r", rename_tag),

	awful.key {
		modifiers   = { modkey },
		keygroup    = "numrow",
		description = "only view tag",
		group       = "tag",
		on_press    = function (index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	},
	awful.key {
		modifiers   = { modkey, mod.control },
		keygroup    = "numrow",
		description = "toggle tag",
		group       = "tag",
		on_press    = function (index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	},
	awful.key {
		modifiers = { modkey, mod.super },
		keygroup    = "numrow",
		description = "move focused client to tag",
		group       = "tag",
		on_press    = function (index)
			if client.focus then
				local tag = client.focus.screen.tags[index]

				if tag then
					client.focus:move_to_tag(tag)
					tag:view_only()
				end
			end
		end,
	},
})
