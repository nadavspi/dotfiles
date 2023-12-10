{...}: let
  hostName = "strasbourg";
  host = builtins.getAttr hostName (import ../../hosts);
in {
  imports = [
    ../../modules/global
    ../../modules/services
    ./hardware-configuration.nix
    ./system.nix
  ];

  networking.hostName = hostName;

  nadavspi = host.options;

  system.stateVersion = "23.11";
}
