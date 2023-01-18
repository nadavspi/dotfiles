#!/usr/bin/env bash
current=$(bspc query -N -n)
case $1 in
	toggle)
		if [[ "$(tabc printclass $current)" == "tabbed" ]]
        then
			tabc detach $current
        else
            tabc create $current
		fi
        ;;
esac
