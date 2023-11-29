{ inputs, outputs, ... }: {
  services.unbound = {
    enable = true;
    settings = { server = { port = [ 5335 ]; }; };
  };
}
