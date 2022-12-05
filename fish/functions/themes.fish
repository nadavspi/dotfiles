function themes
  cd ~/.config/kitty/themes/themes && fzf --preview 'head -n 40 {} && kitty @ set-colors -a -c {}'; cd -
end
