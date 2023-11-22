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

  # dotfiles, not packages
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
  home.packages = with pkgs; [
  ];

  xdg.configFile = prepareLinks { 
    filenames = configFiles;
  };

  home.file = prepareLinks {
    filenames = homeFiles;
    transFilename = file: ".${file}";
  };
}
