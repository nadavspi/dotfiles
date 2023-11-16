{ config, lib, pkgs, specialArgs, ... }:

let 
  inherit (specialArgs) withGUI isDesktop homeDirectory;

  inherit (lib) mkIf;
  inherit (pkgs.stdenv) isLinux isDarwin;

  packages = import ./packages.nix;
  dotfiles = homeDirectory + "/src/dotfiles"; 
in {
  home.stateVersion = "23.05"; 
  programs.home-manager.enable = true;

  home.packages = packages pkgs withGUI;

  # source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "vim";
  };
}
