{config, lib, ...}:
with lib; let
  cfg = config.nadavspi.autoUpgrade;
in {
  options.nadavspi.autoUpgrade = {
    enable = mkEnableOption "autoupgrade";
    allowReboot = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    system.autoUpgrade = {
      allowReboot = cfg.allowReboot;
      enable = true;
      flake = "github:nadavspi/dotfiles";
    };
  };
}
