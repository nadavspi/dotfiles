{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.nadavspi.gitea;
in {
  options.nadavspi.gitea = {
    enable = mkEnableOption "gitea";
  };

  config = mkIf cfg.enable {
    services.gitea = {
      enable = true;
      settings = {
        server = {
          HTTP_PORT = 3050;
          SSH_PORT = 2222;
        };
      };
    };

    networking = {
      firewall = {
        allowedTCPPorts = [3050];
      };
    };
  };
}
