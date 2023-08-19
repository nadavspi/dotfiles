#!/bin/sh

config_dir="${XDG_CONFIG_HOME:-~/.config}"
rm -rf "$config_dir"/mpv/scripts/uosc_shared
wget -P /tmp/ https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip
unzip -od "$config_dir"/mpv/ /tmp/uosc.zip
rm -fv /tmp/uosc.zip
