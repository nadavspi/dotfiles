pkgs: withGUI: with pkgs; [
  bat
  btop
  delta
  eza
  ffmpeg
  fzf
  gnumake
  just
  lazygit
  lf
  mpv
  ncdu
  ncurses
  neovim
  python3
  ripgrep
  speedtest-cli
  starship
  tmux
  tree
  wget
  yt-dlp
  zoxide
  zsh
  zstd
] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
] ++ pkgs.lib.optionals withGUI [
  firefox
  discord
  nerdfonts
  kitty
  1password
]

