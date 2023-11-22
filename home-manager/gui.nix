{ pkgs, dotfiles, config, misc, ... }:

let 
  link = config.lib.file.mkOutOfStoreSymlink;
  prepareLinks = { 
    filenames, 
    transFilename ? file: file,
  }: builtins.listToAttrs(map(filename: {
      name = transFilename(filename); 
      value = { source = link("${dotfiles}/${filename}"); };
      }) filenames);

  packages = with pkgs; [
    i3lock
    lxappearance
    scrot
    xautolock
  ];

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
    "themes"
  ];

in {
  home.packages = packages;

  xdg.configFile = prepareLinks { 
    filenames = configFiles;
  };

  home.file = prepareLinks {
    filenames = homeFiles;
    transFilename = file: ".${file}";
  };
}
