{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../common/global

    ../../common/gui
  ];

  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.autoUpgrade = {
    allowReboot = false;
    enable = true;
    flake = "github:nadavspi/dotfiles";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
