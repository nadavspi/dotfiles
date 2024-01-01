{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.nadavspi.k3s;
in {
  options.nadavspi.k3s = {
    enable = mkEnableOption "k3s";
    clusterInit = mkOption {
      type = types.bool;
      default = false;
    };
    serverAddr = mkOption {
      type = types.string;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [6443 2379 2380];
      allowedUDPPorts = [8472];
    };
    services.k3s = {
      enable = true;
      clusterInit = cfg.clusterInit;
      role = "server";
      serverAddr = mkIf serverAddr "https://" + cfg.serverAddr + ":6443";
      token = "<randomized common secret>";
    };
  };
}
