#!/usr/bin/env bash
file=`mktemp`.sh
tmux capture-pane -pS -32768 > $file
tmux new-window -n:mywindow "$EDITOR '+ normal G $' $file"
