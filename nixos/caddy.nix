{ inputs, outputs, ... }: {
  services.caddy = {
    enable = true;
    virtualHosts."localhost".extraConfig = ''
      respond "Hello, world!"
    '';
  };
}
