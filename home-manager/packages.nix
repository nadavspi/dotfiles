{ config, pkgs, misc, ... }: {
  imports = [
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    bat
    btop
    delta
    eza
    fzf
    gh
    git
    gnumake
    just
    lazygit
    lf
    ncdu
    ncurses
    neovim
    pistol
    python3
    ripgrep
    speedtest-cli
    starship
    tmux
    tree
    wget
    yt-dlp
    zoxide
    zstd
  ];
  fonts.fontconfig.enable = true; 
  programs.dircolors.enable = true;
}
