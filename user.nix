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
    "lf"
    "nvim"
    "starship.toml"
    "tmux"
    "zsh"

    "awesome"
    "kitty"
    "mpv"
    "picom"
    "polybar"
    "rofi"
  ];

  homeFiles = [
    "gitconfig"
    "gitignore"
    "zshenv"
  ];

in {
  xdg.configFile = prepareLinks { 
    filenames = configFiles;
  };

  home.file = prepareLinks {
    filenames = homeFiles;
    transFilename = file: ".${file}";
  };
}
