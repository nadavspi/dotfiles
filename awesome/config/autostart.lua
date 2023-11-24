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
	"lxpolkit &",
	"gnome-keyring-daemon --start --components=secrets",
	"blueman-applet &",
	"nm-applet &",
	"flatpak run org.fcitx.Fcitx5 &",
	"xfce4-power-manager &",
	"xiccd &",
	"1password --silent &",
	"~/src/dotfiles/lock/init.sh &",
	"volumeicon &",
}

for _, command in ipairs(commands) do
	run(command)
end
