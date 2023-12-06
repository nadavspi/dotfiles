{ inputs, overlays, lib, config, pkgs, ... }: {
  imports = [ 
    ./hardware-configuration.nix 
    ../../common/global
  ];

  networking.hostName = "strasbourg";
  networking.networkmanager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
