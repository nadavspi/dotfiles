{...}: {
  imports = [
    ./hardware-configuration.nix
    ./system.nix
    ../../common/global

    ../../common/adguard.nix
    ../../common/unbound.nix
  ];

  networking = {hostName = "strasbourg";};

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
  nadavspi = {
    adguard.enable = true;
    autoUpgrade = {
      enable = true;
      allowReboot = true;
    };
  };

  system.stateVersion = "23.11";
}
