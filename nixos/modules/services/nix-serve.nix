{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.nadavspi.nix-serve;
in {
  options.nadavspi.nix-serve = {
    enable = mkEnableOption "nix-serve";
  };

  config = mkIf cfg.enable {
    services.nix-serve = {
      enable = true;
      openFirewall = true;
      secretKeyFile = "/etc/nixos/cache/cache-priv-key.pem";
    };
  };
}
