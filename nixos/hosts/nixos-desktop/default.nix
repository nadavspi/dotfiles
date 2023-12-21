{
  inputs,
  pkgs,
  ...
}: let
  hostName = "nixos-desktop";
  host = builtins.getAttr hostName (import ../../hosts);
in {
  imports = [
    ./hardware-configuration.nix
    ../../modules/global
    ../../modules/services

    ../../modules/gui
    ../../modules/home.nix
  ];

  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nadavspi = host.options;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
