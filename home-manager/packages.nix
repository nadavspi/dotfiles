{ config, pkgs, misc, ... }: {
  imports = [
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    bat
    btop
    delta
    direnv
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
    nix-direnv
    pistol
    python3
    ripgrep
    speedtest-cli
    starship
    tmux
    tree
    wget
    yt-dlp
    zellij
    zoxide
    zstd
  ];
  fonts.fontconfig.enable = true; 
  programs.dircolors.enable = true;
}
