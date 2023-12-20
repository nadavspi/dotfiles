{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.nadavspi.monitoring.server;
  hosts = import ../../hosts;

  exporterPort = config.services.prometheus.exporters.node.port;
in {
  options.nadavspi.monitoring.server = {
    enable = mkEnableOption "monitoring";
    grafanaPort = mkOption {
      type = types.int;
      default = 2342;
    };
    prometheusPort = mkOption {
      type = types.int;
      default = 9001;
    };
  };

  config = mkIf cfg.enable {
    networking = {
      firewall = {
        allowedTCPPorts = [cfg.grafanaPort cfg.prometheusPort];
      };
    };

    services.grafana = {
      enable = true;
      settings.server = {
        enable_gzip = true;
        http_addr = "0.0.0.0";
        http_port = cfg.grafanaPort;
      };
    };

    services.prometheus = {
      enable = true;
      port = cfg.prometheusPort;

      scrapeConfigs = [
        {
          job_name = "prague";
          static_configs = [
            {
              targets = ["${hosts.prague.ip}:${toString exporterPort}"];
            }
          ];
        }
        {
          job_name = "strasbourg";
          static_configs = [
            {
              targets = ["${hosts.strasbourg.ip}:${toString exporterPort}"];
            }
          ];
        }
        {
          job_name = "ono";
          static_configs = [
            {
              targets = [
                "192.168.1.77:9100"
                "192.168.1.77:9707"
                "192.168.1.77:9708"
                "192.168.1.77:9709"
                "192.168.1.77:9710"
                "192.168.1.77:9711"
              ];
            }
          ];
        }
      ];
    };
  };
}
