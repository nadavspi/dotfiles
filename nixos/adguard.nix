{ inputs, outputs, ... }:
let adguardPort = 3000;
in {
  config = {
    networking = {
      firewall = {
        allowedTCPPorts = [ adguardPort ];
        allowedUDPPorts = [ 53 ];
      };
    };

    services = {
      adguardhome = {
        enable = true;
        mutableSettings = false;
        openFirewall = true;
        settings = {
          bind_port = adguardPort;
          dns = {
            bind_hosts = [ "127.0.0.1" "192.168.1.202" ];
            bootstrap_dns = [ "1.1.1.1" "94.140.14.14" "208.67.222.222" ];
            upstream_dns = [
              "https://1.1.1.1/dns-query"
              "https://1.0.0.1/dns-query"
              "https://dns.nextdns.io"
            ];
            enable_dnssec = true;
            rewrites = [{
              domain = "prague.nadav.is";
              answer = "192.168.1.202";
            }];
          };
        };
      };
    };
  };
}
