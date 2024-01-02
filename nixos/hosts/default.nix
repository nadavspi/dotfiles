{
  prague = {
    ip = "192.168.1.202";
    options = {
      adguard.enable = true;
      tailscale.enable = true;
      autoUpgrade = {
        enable = false;
        allowReboot = false;
      };
      monitoring = {
        server.enable = true;
        exporters.enable = true;
      };
      nix-serve.enable = true;
      k3s = {
        enable = true;
        serverAddr = "https://100.112.215.23:6443";
      };
    };
  };
  strasbourg = {
    ip = "192.168.1.128";
    options = {
      adguard.enable = true;
      autoUpgrade = {
        enable = true;
        allowReboot = true;
      };
      tailscale.enable = true;
      monitoring = {
        exporters.enable = true;
      };
    };
  };
  nixos-desktop = {
    ip = "192.168.1.203";
    options = {
      tailscale.enable = true;
      autoUpgrade = {
        enable = true;
        allowReboot = true;
      };
    };
  };
  shanghai = {
    ip = "100.97.175.125";
  };
  stuttgart = {
    ip = "100.70.145.125";
  };
}
