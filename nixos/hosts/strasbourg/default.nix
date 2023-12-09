{...}: 
let 
  hostName = "strasbourg";

  hosts = import ../../hosts;
  host = builtins.getAttr hostName hosts;
in {
  imports = [
    ./hardware-configuration.nix
    ./system.nix
    ../../modules/global

    ../../modules/services/adguard.nix
    ../../modules/services/unbound.nix
    ../../modules/services/exporters.nix
  ];

  networking.hostName = hostName;

  networking.firewall.extraCommands = "iptables -A INPUT -p vrrp -j ACCEPT";
  services.keepalived = {
    enable = true;
    vrrpInstances.dns = {
      interface = "end0";
      state = "BACKUP";
      priority = 20;
      virtualIps = [{addr = "192.168.1.200";}];
      virtualRouterId = 200;
    };
  };
  nadavspi = host.options;

  system.stateVersion = "23.11";
}
