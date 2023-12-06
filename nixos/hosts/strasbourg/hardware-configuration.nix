{ ... }: {
  imports =
    [ <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-raspberrypi4.nix> ];

  networking.wireless.enable = false;
}
