{ ... }: {
  imports = [ ./hardware-configuration.nix ../../common/global ];
  hardware = {
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    deviceTree = {
      enable = true;
      filter = "*rpi-4-*.dtb";
    };
  };

  boot.loader.grub.enable = false;

  networking.hostName = "strasbourg";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
