{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.nadavspi.flatpak;
in {
  options.nadavspi.flatpak = {
    enable = mkEnableOption "flatpak";
    extraPackages = mkOption {
      type = types.list;
      default = [];
    };
  };

  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  config = mkIf cfg.enable {
    services.flatpak.packages =
      [
        "md.obsidian.Obsidian"
      ]
      ++ cfg.extraPackages;
  };
}
