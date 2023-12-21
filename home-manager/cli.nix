{ pkgs, dotfiles, config, misc, ... }:

let
  link = config.lib.file.mkOutOfStoreSymlink;
  prepareLinks = { filenames, transFilename ? file: file, }:
    builtins.listToAttrs (map (filename: {
      name = transFilename filename;
      value = { source = link "${dotfiles}/${filename}"; };
    }) filenames);

  packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "Hack" ]; })
    bat
    btop
    cachix
    delta
    direnv
    xdragon
    eza
    fd
    fzf
    gcc
    gh
    git
    gnumake
    just
    lazygit
    lf
    ncdu
    ncurses
    neovim
    pipx
    pistol
    python3
    ripgrep
    speedtest-cli
    tree
    wget
    xclip
    yt-dlp
    zellij
    zoxide
    zstd

    alejandra
    lua-language-server
    nil
    nodePackages.bash-language-server
    nodePackages.prettier
    rust-analyzer
    rustfmt
    stylua
    tree-sitter
  ];

  configFiles = [
    "lf"
    "nvim"
    "zellij"
    "zsh"
    "fcitx5" # for now
  ];

  homeFiles = ["gitconfig" "gitignore" "zshenv"];
in {
  imports = [./modules/tmux.nix];

  home.packages = packages;

  xdg.configFile = prepareLinks {filenames = configFiles;};

  home.file = prepareLinks {
    filenames = homeFiles;
    transFilename = file: ".${file}";
  };

  fonts.fontconfig.enable = true;
  programs.dircolors.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
