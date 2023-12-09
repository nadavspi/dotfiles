{config, ...}: let
  exporterPort = config.services.prometheus.exporters.node.port;
  grafanaPort = 2342;
  prometheusPort = 9001;
in {
  imports = [ ./exporters.nix ];

  networking = {
    firewall = {
      allowedTCPPorts = [grafanaPort prometheusPort 80 443];
    };
  };

  services.grafana = {
    enable = true;
    settings.server = {
      enable_gzip = true;
      http_addr = "0.0.0.0";
      http_port = grafanaPort;
    };
  };

  services.prometheus = {
    enable = true;
    port = prometheusPort;

    scrapeConfigs = [
      {
        job_name = "prague";
        static_configs = [{
          targets = [ "127.0.0.1:${toString exporterPort}" ];
        }];
      }
    ];
  };
}
