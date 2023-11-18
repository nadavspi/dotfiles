{ config, pkgs, misc, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    pkgs.abduco
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
    pkgs.tree
    pkgs.wget
    pkgs.yt-dlp
    pkgs.zoxide
    pkgs.zstd
  ];
  fonts.fontconfig.enable = true; 
  home.stateVersion =
    "22.11"; # To figure this out (in-case it changes) you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;
}
