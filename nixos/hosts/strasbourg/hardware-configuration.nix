{ ... }: {
  imports =
    [ <nixpkgs/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix> ];

  networking.wireless.enable = false;
}
