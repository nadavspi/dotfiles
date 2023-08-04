--  rc.lua
--
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
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Introspection
local lgi = require("lgi")
local gtk = lgi.require("Gtk", "3.0")
-- Freedesktop integration
local freedesktop = require("freedesktop")
-- calendar functions
-- local calendar2 = require("calendar2")
-- Extra widgets
local vicious = require("vicious")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- Use personal theme if existing else goto default.
do
    local user_theme, ut
    user_theme = awful.util.getdir("config") .. "/themes/theme.lua"
    ut = io.open(user_theme)
    if ut then
        io.close(ut)
        beautiful.init(user_theme)
    else
        print("Personal theme doesn't exist, falling back to openSUSE")
        beautiful.init(awful.util.get_themes_dir() .. "openSUSE/theme.lua")
    end
end

local lain = require("lain")

require("rules")

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or os.getenv("VISUAL") or "vi"
editor_cmd = terminal .. " -e " .. editor

menubar.utils.terminal = terminal
theme.icon_theme = "Adwaita"

-- alt
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
--
awful.layout.layouts = {
    lain.layout.centerwork,
    awful.layout.suit.tile.left,
}

-- }}}
-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local function lookup_icon(icon, size)
    local icon_theme = gtk.IconTheme.get_default()
    local icon_info = icon_theme:lookup_icon(icon, size, "USE_BUILTIN")
    return icon_info and icon_info:get_filename() or nil
end

mysystemmenu = {
   { "Lock Screen",     "light-locker-command --lock",  lookup_icon("system-lock-screen", 16) },
   { "Logout",           function() awesome.quit() end, lookup_icon("system-log-out", 16)     },
   { "Reboot System",   "systemctl reboot",             lookup_icon("system-restart", 16)       },
   { "Shutdown System", "systemctl poweroff",           lookup_icon("system-shutdown", 16)    }
}

myawesomemenu = {
   { "Restart Awesome", awesome.restart, lookup_icon("view-refresh", 16) },
   { "Edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "rc.lua", lookup_icon("package_settings", 16) },
   { "manual", terminal .. " -e man awesome", lookup_icon("help-browser", 16) }
}

mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome",  myawesomemenu,          beautiful.awesome_icon                },
    },
    after = {
        { "System",   mysystemmenu,           lookup_icon("preferences-system", 16) },
        { "Terminal", menubar.utils.terminal, lookup_icon("utilities-terminal", 16) }
    }
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- We need spacer and separator between the widgets
spacer = wibox.widget.textbox()
separator = wibox.widget.textbox()
spacer:set_text(" ")
separator:set_text("|")

-- Create a textclock widget
mytextclock = wibox.widget.textclock("%a %b %d | %l:%M:%S", 1)
-- calendar2.addCalendarToWidget(mytextclock, "<span color='green'>%s</span>")

-- Keyboard map indicator and changer
-- default keyboard is us, second is german adapt to your needs
--

kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "us", "" } }
kbdcfg.current = 1  -- us is our default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget.set_align = "right"
kbdcfg.widget:set_text(" " .. kbdcfg.layout[kbdcfg.current][1] .. " ")
kbdcfg.switch = function ()
    kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
    local t = kbdcfg.layout[kbdcfg.current]
    kbdcfg.widget.text = " " .. t[1] .. " "
    os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end

-- Mouse bindings
kbdcfg.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () kbdcfg.switch() end)
))

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
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
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

    s.mytaglist = awful.widget.taglist { screen = s, filter = awful.widget.taglist.filter.all,  }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
      screen = s,
      filter = awful.widget.tasklist.filter.focused
    }

    -- Create the wibox
    s.mywibox = awful.wibar({
      position = "bottom",
      screen = s,
      opacity = 0.8
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mytextclock,
            spacer,
            separator,
            spacer,

            kbdcfg.widget,
            wibox.widget.systray(),
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

    awful.key({ modkey }, "n",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "e",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "m",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "i",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Mod4"   }, "n", function () awful.client.swap.bydirection("down")    end),
    awful.key({ modkey, "Mod4"   }, "e", function () awful.client.swap.bydirection("up")    end),
    awful.key({ modkey, "Mod4"   }, "m", function () awful.client.swap.bydirection("left")    end),
    awful.key({ modkey, "Mod4"   }, "i", function () awful.client.swap.bydirection("right")    end),


    --- switch to tag
    awful.key({ modkey }, "j",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[1]
                    if tag then
                       tag:view_only()
                    end
              end),
    awful.key({ modkey }, "l",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[2]
                    if tag then
                       tag:view_only()
                    end
              end),
    awful.key({ modkey }, "u",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[3]
                    if tag then
                       tag:view_only()
                    end
              end),
    awful.key({ modkey }, "y",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[4]
                    if tag then
                       tag:view_only()
                    end
              end),
    awful.key({ modkey }, "apostrophe",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[5]
                    if tag then
                       tag:view_only()
                    end
              end),

    --- toggle tag
    awful.key({ modkey, "Control" }, "j",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[1]
                    if tag then
                       awful.tag.viewtoggle(tag)
                    end
              end),
    awful.key({ modkey, "Control" }, "l",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[2]
                    if tag then
                       awful.tag.viewtoggle(tag)
                    end
              end),
    awful.key({ modkey, "Control" }, "u",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[3]
                    if tag then
                       awful.tag.viewtoggle(tag)
                    end
              end),
    awful.key({ modkey, "Control" }, "y",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[4]
                    if tag then
                       awful.tag.viewtoggle(tag)
                    end
              end),
    awful.key({ modkey }, "apostrophe",
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[5]
                    if tag then
                       awful.tag.viewtoggle(tag)
                    end
              end),

    -- move client to tag
    awful.key({ modkey, "Mod4" }, "j",
              function ()
                  if client.focus then
                      local tag = client.focus.screen.tags[1]
                      if tag then
                          client.focus:move_to_tag(tag)
                          tag:view_only()
                      end
                 end
              end),
    awful.key({ modkey, "Mod4" }, "l",
              function ()
                  if client.focus then
                      local tag = client.focus.screen.tags[2]
                      if tag then
                          client.focus:move_to_tag(tag)
                          tag:view_only()
                      end
                 end
              end),
    awful.key({ modkey, "Mod4" }, "u",
              function ()
                  if client.focus then
                      local tag = client.focus.screen.tags[3]
                      if tag then
                          client.focus:move_to_tag(tag)
                          tag:view_only()
                      end
                 end
              end),
    awful.key({ modkey, "Mod4" }, "y",
              function ()
                  if client.focus then
                      local tag = client.focus.screen.tags[4]
                      if tag then
                          client.focus:move_to_tag(tag)
                          tag:view_only()
                      end
                 end
              end),
    awful.key({ modkey, "Mod4" }, "apostrophe",
              function ()
                  if client.focus then
                      local tag = client.focus.screen.tags[5]
                      if tag then
                          client.focus:move_to_tag(tag)
                          tag:view_only()
                      end
                 end
              end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,           }, "b", function () awful.spawn("firefox") end,
              {description = "open firefox", group = "launcher"}),

    awful.key({ "Control" }, "space", function () awful.spawn("rofi -show drun -theme launcher") end,
               {description = "rofi", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    awful.key({ "Mod4"            }, "i",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ "Mod4"            }, "m",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "m",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "i",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "m",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "i",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"})

)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Mod4" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
