#!/usr/bin/zsh

function cp-torrent () {
  if [[ $# -lt 1 ]]
  then
    echo "Usage: cp-torrent <filename>"
    return 1
  fi
  rsync -avz --remove-source-files $@ seedbox:~/watch/deluge
}
