{ pkgs, config, misc, ... }:

let 
  link = config.lib.file.mkOutOfStoreSymlink;
  fullPath = x: "/home/nadavspi/src/dotfiles/${x}";
  prepareLinks = { files, prefix }: builtins.listToAttrs(map(file: {
      name = file; 
      value = { source = link(fullPath prefix + file); };
      }) files);

  configFiles = [ 
    "nvim"
    "starship.toml"
    "zsh"
  ];

in {

  xdg.configFile = prepareLinks { 
    files = configFiles;
    prefix= ""; 
  };

  home.file = prepareLinks {
    files = ["zshenv"];
    prefix = ".";
  };
}
