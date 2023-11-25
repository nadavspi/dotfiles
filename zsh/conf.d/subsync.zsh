#!/usr/bin/zsh

function subsync () {
  if [[ $# -lt 2 ]]
  then
    echo "Usage: subsync <reference> <input-sub>"
    return 1
  fi
  pipx run ffsubsync $1 -i $2 -o $2.synced.srt
}
