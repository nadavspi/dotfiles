{ ... }: {
  imports = [ ../../common/global ];

  boot.loader.grub.enable = false;
  nixpkgs.hostPlatform = "aarch64-linux";

  networking.hostName = "strasbourg";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
