{
  prague = {
    ip = "192.168.1.202";
    options = {
      adguard.enable = true;
      tailscale.enable = true;
      gitea.enable = true;
      autoUpgrade = {
        enable = true;
        allowReboot = false;
      };
      monitoring = {
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
