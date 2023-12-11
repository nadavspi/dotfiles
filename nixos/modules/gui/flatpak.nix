{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.nadavspi.flatpak;
in {
  options.nadavspi.flatpak = {
    enable = mkEnableOption "flatpak";
    extraPackages = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };

  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      config.common.default = "gtk";
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
    services.flatpak = {
      enable = true;
      packages =
        [
          "md.obsidian.Obsidian"
        ]
        ++ cfg.extraPackages;
    };
  };
}
