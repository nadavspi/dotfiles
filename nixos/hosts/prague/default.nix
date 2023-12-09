{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/global

    ../../modules/services/adguard.nix
    ../../modules/services/caddy.nix
    ../../modules/services/grafana.nix
    ../../modules/services/unbound.nix
    ./keepalived.nix
  ];

  networking.hostName = "prague";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  nadavspi = {
    adguard.enable = true;
    autoUpgrade = {
      enable = true;
      allowReboot = false;
    };
    monitoring = {
      exporters.enable = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
