#!/usr/bin/fish
set wid (xdotool getactivewindow)
set wmclass (xprop -id "$wid" WM_CLASS | awk '{print $4}')

if test "$wmclass" = "\"kitty\""
  kitty @ kitten pass_keys.py neighboring_window $argv[2] null
else
  bspc node -f $argv[1]
end
