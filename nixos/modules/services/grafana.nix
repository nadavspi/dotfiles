{...}: let
  grafanaHost = "grafana.nadav.is";
  grafanaPort = 2342;
in {
  services.grafana = {
    enable = true;
    settings.server = {
      enable_gzip = true;
      http_addr = "0.0.0.0";
      http_port = grafanaPort;
    };
  };

  services.nginx.virtualHosts.${grafanaHost} = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${grafanaPort}";
      proxyWebsockets = true;
    };
  };
}
