{ pkgs, config, misc, ... }:

let 
  fullPath = x: "/home/nadavspi/src/dotfiles/${x}";

  nvim = fullPath "nvim";

  files = [
    {
      target = "nvim";
      path = fullPath "nvim";
    }
  ];

in {

  xdg.configFile = {
    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink nvim;
    };
  };
 
}
