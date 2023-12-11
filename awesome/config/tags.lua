local awful = require("awful")

function getTags ()
	if os.getenv("HOSTNAME") == "shanghai" then
		return { "firefox", "notes", "discord", "kitty", "mpv", "anki" }
	else
		return { "firefox", "notes", "discord", "kitty" }
	end
end

screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag(getTags(), s, awful.layout.layouts[1])
end)
