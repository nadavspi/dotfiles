_: let
  hostName = "prague";
  host = builtins.getAttr hostName (import ../../hosts);
in {
  imports = [
    ../../modules/global
    ../../modules/services
    ./hardware-configuration.nix
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
