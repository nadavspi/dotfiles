{ config, pkgs, misc, ... }: 
let 
  dotfiles = "/home/nadavspi/src/dotfiles";
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  home.file = {
    ".var/app/io.mpv.Mpv/config/mpv" = {
      source = link("${dotfiles}/mpv"); 
    };
  };
}
