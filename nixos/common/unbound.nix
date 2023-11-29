{ pkgs, inputs, outputs, ... }: {
  services.unbound = {
    enable = true;
    enableRootTrustAnchor = true;
    settings = {
      server = {
        port = [ 5335 ];
        prefetch = true;
        serve-expired = true;
        serve-expired-ttl = 86400;
        qname-minimisation = true;
      };
    };
  };
}
