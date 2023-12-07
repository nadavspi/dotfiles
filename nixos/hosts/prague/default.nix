{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../common/global
    ../../common/home.nix

    ../../common/adguard.nix
    ../../common/caddy.nix
    ../../common/unbound.nix
  ];

  networking.hostName = "prague";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
  nadavspi.adguard = {
    enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
