{ config, pkgs, misc, ... }: {

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    pkgs.bat
    pkgs.btop
    pkgs.delta
    pkgs.eza
    pkgs.fzf
    pkgs.gh
    pkgs.git
    pkgs.gnumake
    pkgs.just
    pkgs.lazygit
    pkgs.lf
    pkgs.ncdu
    pkgs.ncurses
    pkgs.neovim
    pkgs.pistol
    pkgs.python3
    pkgs.ripgrep
    pkgs.speedtest-cli
    pkgs.starship
    pkgs.tmux
    pkgs.tree
    pkgs.wget
    pkgs.yt-dlp
    pkgs.zoxide
    pkgs.zstd
  ];
  fonts.fontconfig.enable = true; 
  programs.dircolors.enable = true;
}
