local awful = require("awful")

local function run(command, pidof)
	local findme = command
	local firstspace = command:find(' ')
	if firstspace then
		findme = command:sub(0, firstspace - 1)
	end

	awful.spawn.easy_async_with_shell(string.format('pgrep -u $USER -x %s > /dev/null || (%s)', pidof or findme, command))
end


local commands = {
	"dbus-update-activation-environment --all",
	"gnome-keyring-daemon --start --components=secrets",
	"picom --experimental-backends &",
	"blueman-applet &",
	"fcitx5 &",
	"volumeicon &",
}

for _, command in ipairs(commands) do
	run(command)
end
