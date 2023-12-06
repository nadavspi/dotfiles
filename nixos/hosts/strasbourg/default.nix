{ ... }: {
  imports = [ ./hardware-configuration.nix ../../common/global ];

  networking.hostName = "strasbourg";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
