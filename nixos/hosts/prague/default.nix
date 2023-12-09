{...}: 
let 
  hostName = "prague";

  hosts = import ../../hosts;
  host = builtins.getAttr hostName hosts;
in {
  imports = [
    ./hardware-configuration.nix
    ../../modules/global

    ../../modules/services/adguard.nix
    ../../modules/services/caddy.nix
    ../../modules/services/grafana.nix
    ../../modules/services/tailscale.nix
    ../../modules/services/unbound.nix
    ./keepalived.nix
  ];

  networking.hostName = hostName;
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nadavspi = host.options;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
