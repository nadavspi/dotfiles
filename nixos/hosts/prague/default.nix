{ inputs, overlays, lib, config, pkgs, ... }: {
  imports = [ 
    ./hardware-configuration.nix 
    ../../common/global
    ../../common/home.nix 
     
    ../../common/adguard.nix 
    ../../common/caddy.nix 
    ../../common/unbound.nix 
  ];

  networking.hostName = "prague";
  networking.networkmanager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
