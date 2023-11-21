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

  configFiles = [ 
    "lf"
    "nvim"
    "starship.toml"
    "zellij"
    "zsh"
    "fcitx5" # for now
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
