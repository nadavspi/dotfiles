_: {
  networking.firewall.extraCommands = "iptables -A INPUT -p vrrp -j ACCEPT";
  services.keepalived = {
    enable = true;
    vrrpInstances.dns = {
      interface = "enp1s0";
      state = "MASTER";
      priority = 50;
      virtualIps = [{addr = "192.168.1.200";}];
      virtualRouterId = 200;
    };
  };
}
