{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.nadavspi.tailscale;
in {
  options.nadavspi.tailscale = {
    enable = mkEnableOption "tailscale";
  };

  config = mkIf cfg.enable {
    services.tailscale.enable = true;
  };
}
