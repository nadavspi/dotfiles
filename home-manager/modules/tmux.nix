{
  pkgs,
  config,
  dotfiles,
  ...
}: let
  link = config.lib.file.mkOutOfStoreSymlink;
  prepareLinks = {
    filenames,
    transFilename ? file: file,
  }:
    builtins.listToAttrs (map (filename: {
        name = transFilename filename;
        value = {source = link "${dotfiles}/${filename}";};
      })
      filenames);

  configFiles = [
    "tmux"
  ];
in {
  home.packages = with pkgs; [
    tmux
  ];

  xdg.configFile = prepareLinks {filenames = configFiles;};
}
