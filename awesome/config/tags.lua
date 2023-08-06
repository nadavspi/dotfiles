local awful = require("awful")
local lain = require("lain")
local tyrannical = require("tyrannical")

local center = lain.layout.centerwork
local tile = awful.layout.suit.tile.left

tyrannical.tags = {
	{
		name = "firefox",
		init = true,
		exec_once = { "firefox" },
		layout = center,
	},
	{
		name = "kitty",
		init = true,
		exec_once = { "kitty" },
		layout = center,
	},
	{
		name = "obsidian",
		init = true,
		layout = center,
		class = { "obsidian" },
	},
	{
		name = "discord",
		init = true,
		layout = center,
		exec_once = { "discord" },
		class = { "discord" },
	},
	{
		name = "files",
		init = true,
		layout = center,
		exec_once = { "kitty -e nnn" },
		class = { "Thunar" }
	},
}

-- Ignore the tag "exclusive" property for the following clients (matched by classes)
tyrannical.properties.intrusive = {
	"ksnapshot"     , "pinentry"       , "gtksu"     , "kcalc"        , "xcalc"               ,
	"feh"           , "Gradient editor", "About KDE" , "Paste Special", "Background color"    ,
	"kcolorchooser" , "plasmoidviewer" , "Xephyr"    , "kruler"       , "plasmaengineexplorer",
}

-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
	"MPlayer"      , "pinentry"        , "ksnapshot"  , "pinentry"     , "gtksu"          ,
	"xine"         , "feh"             , "kmix"       , "kcalc"        , "xcalc"          ,
	"yakuake"      , "Select Color$"   , "kruler"     , "kcolorchooser", "Paste Special"  ,
	"New Form"     , "Insert Picture"  , "kcharselect", "mythfrontend" , "plasmoidviewer"
}

-- Make the matching clients (by classes) on top of the default layout
tyrannical.properties.ontop = {
	"Xephyr"       , "ksnapshot"       , "kruler"
}

-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.placement = {
	kcalc = awful.placement.centered
}

tyrannical.settings.block_children_focus_stealing = true --Block popups ()
tyrannical.settings.group_children = true --Force popups/dialogs to have the same tags as the parent client

