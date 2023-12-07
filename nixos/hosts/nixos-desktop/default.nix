{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../common/global
  ];

  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
