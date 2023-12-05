{ config, pkgs, misc, ... }:
let
  dotfiles = "/home/nadavspi/src/dotfiles";
  link = config.lib.file.mkOutOfStoreSymlink;
  prepareLinks = { filenames, transFilename ? file: file, }:
    builtins.listToAttrs (map (filename: {
      name = transFilename (filename);
      value = { source = link ("${dotfiles}/${filename}"); };
    }) filenames);
  packages = with pkgs; [
    abook
    cacert
    isync
    lynx
    msmtp
    mutt-wizard
    neomutt
    notmuch
    pass
    urlview
  ];

  configFiles = [ "mutt" "msmtp" ];
  homeFiles = [ "mbsyncrc" "notmuch-config" ];
in {
  home.packages = packages;

  xdg.configFile = prepareLinks { filenames = configFiles; };

  home.file = prepareLinks {
    filenames = homeFiles;
    transFilename = file: ".${file}";
  };
}
