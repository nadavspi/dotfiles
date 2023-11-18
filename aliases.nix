{ pkgs, misc, ... }: {
  # DO NOT EDIT: This file is managed by fleek. Manual changes will be overwritten.
   home.shellAliases = {
    "apply-brooklyn" = "nix run --impure home-manager/master -- -b bak switch --flake .#nadavspi@brooklyn";
    
    "apply-fedora" = "nix run --impure home-manager/master -- -b bak switch --flake .#nadavspi@fedora";
    
    "apply-mac-mini-m2.local" = "nix run --impure home-manager/master -- -b bak switch --flake .#nadavspi@mac-mini-m2.local";
    
    "fleeks" = "cd ~/src/dotfiles";
    
    "latest-fleek-version" = "nix run https://getfleek.dev/latest.tar.gz -- version";
    
    "update-fleek" = "nix run https://getfleek.dev/latest.tar.gz -- update";
    };
}
