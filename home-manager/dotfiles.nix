{ config, lib, pkgs, specialArgs, ... }:

let 
  inherit (specialArgs) withGUI isDesktop dotfiles;

  inherit (lib) mkIf;
  inherit (pkgs.stdenv) isLinux isDarwin;

in {
  home.file = {
    ".gitignore".source = .././gitignore;
  };

  xdg.configFile = {
    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nvim";
    };
  };
}
