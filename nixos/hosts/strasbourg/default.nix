{...}: 
let 
  hostName = "strasbourg";

  hosts = import ../../hosts;
  host = builtins.getAttr hostName hosts;
in {
  imports = [
    ./hardware-configuration.nix
    ./system.nix
    ../../modules/global

    ../../modules/services/adguard.nix
    ../../modules/services/unbound.nix
    ../../modules/services/exporters.nix
  ];

  networking.hostName = hostName;

  nadavspi = host.options;

  system.stateVersion = "23.11";
}
