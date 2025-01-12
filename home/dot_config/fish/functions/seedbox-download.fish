function seedbox-download
  rsync -avz --progress seedbox:downloads/qbittorrent/snatched/ /Volumes/torrents/seedbox/downloads
end
