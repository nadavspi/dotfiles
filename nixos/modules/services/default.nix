{...}: {
  imports = [
    ./adguard.nix
    ./exporters.nix
    ./grafana.nix
    ./nix-serve.nix
    ./tailscale.nix
  ];
}
