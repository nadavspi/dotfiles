local awful = require("awful")

awful.spawn.with_shell(
	'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;'
		.. 'xrdb -merge <<< "awesome.started:true";'
		.. "flatpak run org.fcitx.Fcitx5 &;"
		.. "~/src/dotfiles/lock/init.sh &;"
		.. "dex --environment Awesome --autostart"
)
