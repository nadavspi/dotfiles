{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nadavspi.monitoring.exporters;
in {
  options.nadavspi.monitoring.exporters = {
    enable = mkEnableOption "exporters";
    port = mkOption {
      type = types.int;
      default = 9002;
    };
  };

  config = mkIf cfg.enable {
    services.prometheus = {
      exporters = {
        node = {
          enable = true;
          enabledCollectors = ["systemd"];
          inherit (cfg) port;
        };
      };
    };

    networking = {
      firewall = {
        allowedTCPPorts = [cfg.port];
      };
    };
  };
}
