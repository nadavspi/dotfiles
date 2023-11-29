{ inputs, outputs, ... }: {
  services.caddy = {
    enable = true;
    virtualHosts."192.168.1.202" = {
      extraConfig = ''
        reverse_proxy http://192.168.1.202:3000
        tls internal
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
