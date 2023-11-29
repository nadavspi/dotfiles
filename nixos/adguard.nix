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

    networking.firewall.extraCommands = "iptables -A INPUT -p vrrp -j ACCEPT";
    services.keepalived = {
      enable = true;
      vrrpInstances.dns = {
        interface = "enp1s0";
        state = "MASTER";
        priority = 50;
        virtualIps = [{ addr = "192.168.1.200"; }];
        virtualRouterId = 200;
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
            bind_hosts = [ "192.168.1.202" "192.168.1.200" ];
            bootstrap_dns = [ "1.1.1.1" "94.140.14.14" "208.67.222.222" ];
            upstream_dns = [
              "127.0.0.1:5335"
              "https://1.1.1.1/dns-query"
              "https://freedns.controld.com/no-ads-typo"
            ];
            all_servers = true;
            enable_dnssec = true;
            rewrites = [{
              domain = "prague.nadav.is";
              answer = "192.168.1.202";
            }];
          };
          filters = [
            {
              ID = 1;
              enabled = true;
              name = "oisd big";
              url = "https://big.oisd.nl/";
            }
            {
              ID = 2;
              enabled = true;
              name = "HaGeZi's Pro DNS Blocklist";
              url =
                "https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/pro.txt";
            }
            {
              ID = 3;
              enabled = true;
              name = "CHN anti-ad";
              url = "https://anti-ad.net/easylist.txt";
            }
          ];
          schema_version = 24;
        };
      };
    };
  };
}
