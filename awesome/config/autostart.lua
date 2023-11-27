local awful = require("awful")

awful.spawn.with_shell(
	'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;'
		.. 'xrdb -merge <<< "awesome.started:true";'
		.. 'dbus-update-activation-environment --all;'
		.. "~/src/dotfiles/lock/init.sh &;"
		.. "dex --environment Awesome --autostart"
)
