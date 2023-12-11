{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.nadavspi.adguard;
  rewrites = [
    {
      domain = "*.nadav.is";
      answer = "192.168.1.77";
    }
    {
      domain = "www.nadav.is";
      answer = "76.76.21.21";
    }
    {
      domain = "dns.nadav.is";
      answer = "192.168.1.200";
    }
    {
      domain = "stuttgart.nadav.is";
      answer = "192.168.1.27";
    }
    {
      domain = "shanghai.nadav.is";
      answer = "192.168.1.7";
    }
    {
      domain = "fedora.nadav.is";
      answer = "192.168.1.193";
    }
    {
      domain = "prague.nadav.is";
      answer = "192.168.1.202";
    }
    {
      domain = "houston.nadav.is";
      answer = "192.168.1.22";
    }
    {
      domain = "strasbourg.nadav.is";
      answer = "192.168.1.128";
    }
    {
      domain = "nixos-desktop.nadav.is";
      answer = "192.168.1.203";
    }
    {
      domain = "grafana.nadav.is";
      answer = "192.168.1.202";
    }
  ];
in {
  options.nadavspi.adguard = {
    enable = mkEnableOption "adguardhome";
    webPort = mkOption {
      type = types.int;
      default = 3000;
    };
    haIpAddress = mkOption {
      type = types.string;
      default = "192.168.1.200";
    };
  };

  config = mkIf cfg.enable {
    networking = {
      firewall = {
        allowedTCPPorts = [cfg.webPort];
        allowedUDPPorts = [53];
      };
    };

    services = {
      adguardhome = {
        enable = true;
        mutableSettings = false;
        openFirewall = true;
        settings = {
          bind_port = cfg.webPort;
          dns = {
            bind_hosts = ["0.0.0.0"];
            bootstrap_dns = ["1.1.1.1" "94.140.14.14" "208.67.222.222"];
            upstream_dns = [
              "127.0.0.1:5335"
              "https://1.1.1.1/dns-query"
              "https://freedns.controld.com/no-ads-typo"
            ];
            all_servers = true;
            enable_dnssec = true;
            rewrites = rewrites;
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
              url = "https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/pro.txt";
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

      unbound = {
        enable = true;
        enableRootTrustAnchor = true;
        settings = {
          server = {
            port = [5335];
            prefetch = true;
            serve-expired = true;
            serve-expired-ttl = 86400;
            qname-minimisation = true;
          };
        };
      };
    };
  };
}
