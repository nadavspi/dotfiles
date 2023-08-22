local awful = require("awful")

function getTags ()
	if os.getenv("HOSTNAME") == "shanghai" then
		return { "firefox", "obsidian", "files", "mpv", "anki", "kitty", "discord" }
	else
		return { "firefox", "obsidian", "discord", "kitty" }
	end
end

screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag(getTags(), s, awful.layout.layouts[1])
end)
