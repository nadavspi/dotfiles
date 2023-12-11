{
  prague = {
    ip = "192.168.1.202";
    options = {
      adguard.enable = true;
      tailscale.enable = true;
      autoUpgrade = {
        enable = true;
        allowReboot = false;
      };
      monitoring = {
        server.enable = true;
        exporters.enable = true;
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
}
