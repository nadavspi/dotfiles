{ config, pkgs, misc, ... }: {
  imports = [ ];

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "Hack" ]; })
    bat
    btop
    delta
    direnv
    dragon
    eza
    fd
    fzf
    gcc
    gh
    git
    gnumake
    just
    lazygit
    lf
    ncdu
    ncurses
    neovim
    pipx
    pistol
    python3
    ripgrep
    speedtest-cli
    tree
    wget
    xclip
    yt-dlp
    zellij
    zoxide
    zstd

    lua-language-server
    nil
    nixfmt
    stylua
    tree-sitter
  ];
  fonts.fontconfig.enable = true;
  programs.dircolors.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };


}
