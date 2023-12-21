{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.nadavspi.HI;
in {
  options.nadavspi.HI = {
    enable = mkEnableOption "HI";
  };

  config = mkIf cfg.enable {
    services.HI = {
      enable = true;
    };
  };
}
