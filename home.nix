{ config, pkgs, misc, ... }: {
  # DO NOT EDIT: This file is managed by fleek. Manual changes will be overwritten.
  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
      
      
    };
  };

  
  # managed by fleek, modify ~/.fleek.yml to change installed packages
  
  # packages are just installed (no configuration applied)
  # programs are installed and configuration applied to dotfiles
  home.packages = [
    # user selected packages
    pkgs.bat
    pkgs.btop
    pkgs.delta
    pkgs.eza
    pkgs.fzf
    pkgs.gnumake
    pkgs.just
    pkgs.lazygit
    pkgs.lf
    pkgs.ncdu
    pkgs.ncurses
    pkgs.python3
    pkgs.ripgrep
    pkgs.speedtest-cli
    pkgs.starship
    pkgs.tmux
    pkgs.tree
    pkgs.wget
    pkgs.yt-dlp
    pkgs.zoxide
    pkgs.zsh
    pkgs.zstd
    pkgs.neovim
    # Fleek Bling
    pkgs.git
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  fonts.fontconfig.enable = true; 
  home.stateVersion =
    "22.11"; # To figure this out (in-case it changes) you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;
}
