export XSECURELOCK_FONT="Hack Nerd Font:size=18" 
export XSECURELOCK_PASSWORD_PROMPT="disco"
export XSECURELOCK_SHOW_KEYBOARD_LAYOUT=0
export XSECURELOCK_SAVER=~/src/dotfiles/lock/saved_feh
export XSECURELOCK_AUTH_BACKGROUND_COLOR="#a0785a"
xset s 600 5
xss-lock -n ~/.nix-profile/libexec/xsecurelock/dimmer -l -- xsecurelock
xfconf-query --create -c xfce4-session -p /general/LockCommand -t string -s "loginctl lock-session"
