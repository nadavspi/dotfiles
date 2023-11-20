{ pkgs, config, misc, ... }:

let 
  dotfiles = "/home/nadavspi/src/dotfiles";

  link = config.lib.file.mkOutOfStoreSymlink;
  prepareLinks = { 
    filenames, 
    transFilename ? file: file,
  }: builtins.listToAttrs(map(filename: {
      name = transFilename(filename); 
      value = { source = link("${dotfiles}/${filename}"); };
      }) filenames);

  configFiles = [ 
    "awesome"
    "fcitx5"
    "kitty"
    "mpv"
    "picom"
    "polybar"
    "rofi"
  ];

  homeFiles = [
  ];

in {
  xdg.configFile = prepareLinks { 
    filenames = configFiles;
  };

  home.file = prepareLinks {
    filenames = homeFiles;
    transFilename = file: ".${file}";
  };

  home.packages = with pkgs; [
    picom-allusive
  ];
}
