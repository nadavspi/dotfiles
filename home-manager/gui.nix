{ pkgs, dotfiles, config, misc, ... }:

let 
  link = config.lib.file.mkOutOfStoreSymlink;
  prepareLinks = { 
    filenames, 
    transFilename ? file: file,
  }: builtins.listToAttrs(map(filename: {
      name = transFilenamefilename; 
      value = { source = link"${dotfiles}/${filename}"; };
      }) filenames);

  packages = with pkgs; [
    dex
    lxappearance
    xorg.xset
    xsecurelock
    xss-lock
  ];

  configFiles = [ 
    "autostart"
    "awesome"
    "kitty"
    "mpv"
    "picom"
    "polybar"
    "redshift.conf"
    "rofi"
  ];

  homeFiles = [
    "themes"
  ];

in {
  imports = [
    ./modules/mutt.nix
  ];

  home.packages = packages;

  xdg.configFile = prepareLinks { 
    filenames = configFiles;
  };

  home.file = prepareLinks {
    filenames = homeFiles;
    transFilename = file: ".${file}";
  };
}
