{ ... }: {
  imports = [ ./hardware-configuration.nix ../../common/global ];

  boot.loader.grub.enable = false;

  networking.hostName = "strasbourg";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
