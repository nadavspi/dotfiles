#!/usr/bin/zsh

function cp-sync () {
  if [[ $# -lt 2 ]]
  then
    echo "Usage: copy-from-sync <filename> <path>"
    return 1
  fi
  ssh ono rsync -avz --progress --remove-source-files /mnt/user/data/sync/$1 /mnt/user/data/media/$2
}
